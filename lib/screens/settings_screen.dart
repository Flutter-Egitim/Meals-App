import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meals_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _buildInfoCard() {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                tr("Global.version"),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                "1.0.0",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text(
                "Meals App",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(tr("About.discover")),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard() {
    final easyLocalization = EasyLocalization.of(context)!;
    final supportedLocales = easyLocalization.supportedLocales;
    final currentLocale = easyLocalization.locale;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 12),
                Text(
                  tr("Global.language"),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...supportedLocales.map(
              (locale) => ListTile(
                leading: Icon(Icons.flag),
                title: Text(
                  locale.languageCode.toUpperCase() +
                      (locale.countryCode != null
                          ? ' (${locale.countryCode})'
                          : ''),
                ),
                trailing: Radio<Locale>(
                  value: locale,
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      context.setLocale(value);
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                onTap: () => context.setLocale(locale),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildThemeCard(ThemeProvider themeProvider) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 12),
                Text(
                  tr("Settings.theme-mode"),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildThemeOption(
              themeProvider,
              ThemeMode.system,
              tr("Settings.system.title"),
              tr("Settings.system.description"),
              Icons.settings_outlined,
            ),
            _buildThemeOption(
              themeProvider,
              ThemeMode.dark,
              tr("Settings.dark.title"),
              tr("Settings.dark.description"),
              Icons.dark_mode_outlined,
            ),
            _buildThemeOption(
              themeProvider,
              ThemeMode.light,
              tr("Settings.light.title"),
              tr("Settings.light.description"),
              Icons.light_mode_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    ThemeProvider themeProvider,
    ThemeMode mode,
    String title,
    String subTitle,
    IconData icon,
  ) {
    final isSelected = themeProvider.themeMode == mode;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline.withAlpha(100),
          width: isSelected ? 2 : 1,
        ),
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withAlpha(20)
            : Colors.transparent,
      ),
      child: ListTile(
        leading: Container(padding: EdgeInsets.all(8), child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subTitle),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        trailing: Radio<ThemeMode>(
          value: mode,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
          },
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        onTap: () => themeProvider.setThemeMode(mode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr("Global.settings")), centerTitle: false),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(tr("Settings.apperience")),
                SizedBox(height: 16),
                _buildThemeCard(themeProvider),
                SizedBox(height: 32),

                _buildSectionHeader(tr("Global.language")),
                SizedBox(height: 16),
                _buildLanguageCard(),
                SizedBox(height: 32),

                _buildSectionHeader(tr("Global.about")),
                SizedBox(height: 16),
                _buildInfoCard(),
              ],
            ),
          );
        },
      ),
    );
  }
}
