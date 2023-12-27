import 'package:bookbuddies/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); 
  runApp(Provider(
      create: (context) => CookieRequest(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Buddies',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: SplashScreen(),
    );
  }
}
