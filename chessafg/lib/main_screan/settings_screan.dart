import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../provider/infomation/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(themeProvider.language == 'English'
              ? 'Sittings'
              : themeProvider.language == 'فارسی'
                  ? 'تنظیمات'
                  : themeProvider.language == 'پشتو'
                  ? 'ژبه'
                  : themeProvider.language == 'German'
                      ? 'Einstellungen'
                      : 'Sittings', // Default fallback'
                      ),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ListView(
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text(themeProvider.language == 'English'
              ? 'Dark Mode'
              : themeProvider.language == 'فارسی'
                  ? 'حالت تاریک'
                  : themeProvider.language == 'پشتو'
                  ? 'تیاره حالت'
                  : themeProvider.language == 'German'
                      ? 'Dunkler Modus'
                      : 'Dark Mode', // Default fallback'
                ),
                trailing: Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.text_fields),
                title: Text(themeProvider.language == 'English'
              ? 'Text Size'
              : themeProvider.language == 'فارسی'
                  ? ' اندازه خط'
                  : themeProvider.language == 'پشتو'
                  ? 'د متن اندازه'
                  : themeProvider.language == 'German'
                      ? 'Liniengröße'
                      : 'Text Size', // Default fallback''Text Size'
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      double newSize = themeProvider.textSize;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Text(themeProvider.language == 'English'
              ? 'Select Text Size'
              : themeProvider.language == 'فارسی'
                  ? '  اندازه خط را انخاب کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'د متن اندازه وټاکئ'
                  : themeProvider.language == 'German'
                      ? 'Wählen Sie die Schriftgröße aus'
                      : 'Select Text Size', // Default fallback''Select Text Size'
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Slider(
                                  value: newSize,
                                  min: 10.0,
                                  max: 30.0,
                                  divisions: 20,
                                  label: newSize.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      newSize = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  themeProvider.setTextSize(newSize);
                                  Navigator.of(context).pop();
                                },
                                child: Text(themeProvider.language == 'English'
              ? 'OK'
              : themeProvider.language == 'فارسی'
                  ? 'قبول'
                  : themeProvider.language == 'پشتو'
                  ? ' منل کېدل'
                  : themeProvider.language == 'German'
                      ? 'OK'
                      : 'OK',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(themeProvider.language == 'English'
              ? 'Language'
              : themeProvider.language == 'فارسی'
                  ? 'زبان'
                  : themeProvider.language == 'پشتو'
                  ? 'ژبه'
                  : themeProvider.language == 'German'
                      ? 'Sprache'
                      : 'Language',
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String newLang = themeProvider.language;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Text(themeProvider.language == 'English'
              ? 'Select Language'
              : themeProvider.language == 'فارسی'
                  ? 'زبان را انتخاب کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'ژبه غوره کړه'
                  : themeProvider.language == 'German'
                      ? 'Sprache auswählen'
                      : 'Select Language',
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButton<String>(
                                  value: newLang,
                                  items: ['English', 'فارسی', 'German','پشتو']
                                      .map((lang) => DropdownMenuItem<String>(
                                            value: lang,
                                            child: Text(lang),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      newLang = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  themeProvider.setLanguage(newLang);
                                  Navigator.of(context).pop();
                                },
                                child: Text(themeProvider.language == 'English'
              ? 'OK'
              : themeProvider.language == 'فارسی'
                  ? 'قبول'
                  : themeProvider.language == 'پشتو'
                  ? ' منل کېدل'
                  : themeProvider.language == 'German'
                      ? 'OK'
                      : 'OK',),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text(themeProvider.language == 'English'
              ? 'Change Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور را تغییر دهید'
                  : themeProvider.language == 'پشتو'
                  ? ' پټ نوم بدل کړی'
                  : themeProvider.language == 'German'
                      ? 'Kennwort ändern'
                      : 'Change Password',
                ),
                onTap: () {
                  Navigator.pushNamed(context, Constants.changePasswordScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(themeProvider.language == 'English'
              ? 'Sign Out'
              : themeProvider.language == 'فارسی'
                  ? 'خروج از سیستم'
                  : themeProvider.language == 'پشتو'
                  ? 'وتون'
                  : themeProvider.language == 'German'
                      ? 'Abmelden'
                      : 'Sign Out',),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.loginScreen, (route) => false);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
