import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'screens/splash_video_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const SwajanApp(),
    ),
  );
}

class SwajanApp extends StatelessWidget {
  const SwajanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'SWAJAN',
      debugShowCheckedModeBanner: false,
      locale: languageProvider.locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('gu', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00005C)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const SplashVideoScreen(),
    );
  }
}

