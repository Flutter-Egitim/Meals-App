import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/providers/theme_provider.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();

  runApp(ChangeNotifierProvider.value(value: themeProvider, child: App()));
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
              seedColor: Color.fromARGB(255, 29, 120, 157),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 29, 120, 157),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          themeMode: themeProvider.themeMode,
          home: const CategoryScreen(),
        );
      },
    );
  }
}
