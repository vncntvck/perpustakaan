import 'package:flutter/material.dart';
import 'package:perpustakaan/homepage/profile.dart';
// import 'package:perpustakaan/login/sigin.dart';
// import 'package:perpustakaan/homepage/homepage.dart';
// import 'package:perpustakaan/navbar/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ypnhaxqiidkoykgbwrvb.supabase.co',
    anonKey: 
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwbmhheHFpaWRrb3lrZ2J3cnZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYwODY1MzEsImV4cCI6MjAzMTY2MjUzMX0.XWgz58xKCtUWAIGuyM320czd5KnA5XPW8lK6bu3DXWg',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: Profile(),
    );
  }
}