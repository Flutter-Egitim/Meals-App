import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/providers/theme_provider.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_provider.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadThemeMode()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = Provider.of<FavoriteProvider>(context).favorites;

    final List<Widget> screens = [
      CategoryScreen(),
      MealsScreen(title: null, meals: favoriteMeals),
    ];

    final List<String> screenTitles = ["Selected Category", "Favorite"];

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 143, 157, 52),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 232, 255, 82),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          themeMode: themeProvider.themeMode,
          home: Scaffold(
            appBar: AppBar(
              title: Text(screenTitles[_selectedIndex]),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  ),
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            body: screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Kategori",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favori",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
