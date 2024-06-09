import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perpustakaan/homepage/homepage.dart';
import 'package:perpustakaan/login/sigin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  String? _uploadedImageUrl;
  String? _currentUserId;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      return;
    }
    _currentUserId = currentUser.id;
    _username = currentUser.userMetadata?['username'];

    print('Loaded user ID: $_currentUserId');
    print('Loaded username: $_username');

    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('userId');
    final storedImageUrl = prefs.getString('uploadedImageUrl');

    if (storedUserId == _currentUserId && storedImageUrl != null) {
      setState(() {
        _uploadedImageUrl = storedImageUrl;
      });
    } else {
      final response = await Supabase.instance.client
          .from('profile_tes')
          .select('profile_image_url')
          .eq('user_id', _currentUserId)
          .single();

      if (response.error != null) {
        // Handle error
        print('Error loading profile: ${response.error!.message}');
        return;
      }

      if (response.data != null && response.data['profile_image_url'] != null) {
        setState(() {
          _uploadedImageUrl = response.data['profile_image_url'];
        });

        // Save the image URL and user ID using SharedPreferences
        await _saveUserProfile(_currentUserId!, response.data['profile_image_url']);
      }
    }

    setState(() {}); // Ensure the UI updates with the loaded data
  }

  Future<void> _saveUserProfile(String userId, String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('uploadedImageUrl', imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                    ),
                    actions: [],
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      if (_uploadedImageUrl == null || _uploadedImageUrl!.isEmpty)
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        )
                      else
                        ClipOval(
                          child: Image.network(
                            _uploadedImageUrl!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _upload,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    _username ?? 'Unknown User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID: $_currentUserId',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildProfileOption(Icons.lock, 'Password'),
                _buildProfileOption(Icons.email, 'Email Address'),
                _buildProfileOption(Icons.support, 'Support'),
                _buildProfileOption(Icons.logout, 'Sign Out'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
      onTap: () async {
        if (title == 'Sign Out') {
          _showSignOutConfirmationDialog();
        } else {
          // Handle navigation to respective pages
        }
      },
    );
  }

  Future<void> _showSignOutConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('uploadedImageUrl');
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Sigin()),
    );
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = 'public/$fileName';

      await Supabase.instance.client.storage.from('profile_tes').uploadBinary(
        filePath,
        bytes,
        fileOptions: FileOptions(contentType: imageFile.mimeType),
      );

      final response = await Supabase.instance.client.storage
          .from('profile_tes')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);

      setState(() {
        _uploadedImageUrl = response;
      });

      // Save the image URL and user ID using SharedPreferences
      await _saveUserProfile(_currentUserId!, response);

      print('Uploaded profile image url: $response');

      // Insert the uploaded image URL into the profile_tes table with the user ID
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        final insertResponse = await Supabase.instance.client
            .from('profile_tes')
            .upsert({
              'user_id': userId,
              'profile_image_url': response,
              'updated_at': DateTime.now().toIso8601String(),
            });

        if (insertResponse.error != null) {
          throw insertResponse.error!;
        }
      } else {
        // Handle the case where the user ID is null
        throw Exception('User is not logged in');
      }
    } on StorageException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    // } catch (error) {
    //   print('Unexpected error: $error'); // Print the error for debugging
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Unexpected error occurred: $error'),
    //       backgroundColor: Theme.of(context).colorScheme.error,
    //     ),
    //   );
    }
    setState(() => _isLoading = false);
  }
}