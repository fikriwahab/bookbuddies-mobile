import 'package:bookbuddies/pages/SplashScreen.dart';
import 'package:bookbuddies/providers/bookmark_provider.dart';
import 'package:bookbuddies/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<CookieRequest>(
          create: (context) => CookieRequest(),
        ),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        // Add other providers as needed
      ],
      child: MyApp(),
    ),
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
