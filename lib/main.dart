import 'package:first_pro/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://cgkkdliihqbdeiuqkmzq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNna2tkbGlpaHFiZGVpdXFrbXpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjYyODY3MjQsImV4cCI6MTk4MTg2MjcyNH0.5LgxVlcTvor2MtIT6qFfj7ovUqHBIqbYz0nWkqwLDCk');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
