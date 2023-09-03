import 'package:flutter/material.dart';
import 'package:cctv/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart'; // Import Firebase Core

Future<void> main() async {
  // Make the notification bar white
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.white,
  ));
  // End of Make the notification bar white
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // useMaterial3: true, // Uncomment this line if you are using Material 3
      ),
      home: const HomePage(),
    );
  }
}
