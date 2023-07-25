import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movies/providers/providers.dart';
import 'package:flutter_movies/screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
        "detail": (context) => const DetailScreen(),
      },
      theme: _getTheme(),
    );
  }

  ThemeData _getTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
      ),
    );
  }
}
