import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/providers/theme_provider.dart';
import 'package:meals_app/widget_tree.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final themeProvider = ThemeProvider();
  themeProvider.loadThemeMode();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/translations',
      fallbackLocale: Locale('tr', 'TR'),
      child: ChangeNotifierProvider.value(value: themeProvider, child: App()),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 143, 157, 52),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 232, 255, 82),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          themeMode: themeProvider.themeMode,

          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          home: const WidgetTree(),
        );
      },
    );
  }
}
