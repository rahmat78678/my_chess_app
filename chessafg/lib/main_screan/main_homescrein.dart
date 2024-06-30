import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/main_screan/PlayerStatsScreen.dart';
//import 'package:chessafg/main.dart';
import 'package:chessafg/main_screan/about_screan.dart';
import 'package:chessafg/main_screan/game_screan.dart';
import 'package:chessafg/main_screan/gametime_screaan.dart';
import 'package:chessafg/main_screan/settings_screan.dart';
import 'package:chessafg/main_screan/user_data_screen.dart';
import 'package:chessafg/provider/game_provider.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chessafg/homescreenn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(themeProvider.language == 'English'
              ? 'AFG Chess'
              : themeProvider.language == 'فارسی'
                  ? 'شطرنج افغانستان'
                  : themeProvider.language == 'پشتو'
                  ? 'د افغانستان شطرنج '
                  : themeProvider.language == 'German'
                      ? 'AFG Schach'
                      : 'AFG Chess',
          style: TextStyle(color: Colors.white),
        ),
         leading: IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDataScreen(),
                  ),
                );
          },
        ),
      ),
      
      body: Center(
        child: Padding(
          
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            
            children: [
             
              buildGameType(
                
                lable: themeProvider.language == 'English'
                ? 'Play vs Computer'
                : themeProvider.language == 'فارسی'
                    ? 'بازی با کامپیوتر'
                    : themeProvider.language == 'پشتو'
                    ? 'کمپیوټر سره لوبې '
                    : themeProvider.language == 'German'
                        ? 'Spielen gegen Computer'
                        : 'Play vs Computer',
                icon: Icons.computer,
                onTap: () {
                  gameProvider.setVsComputer(value: true);
                  // navigate to setup game time screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameTimeScreen(),
                    ),
                  );
                },
              ),
              buildGameType(
                lable: themeProvider.language == 'English'
                ? 'Play vs Friend'
                : themeProvider.language == 'فارسی'
                    ? 'بازی با دوست'
                    : themeProvider.language == 'پشتو'
                    ? 'ملګری سره لوبې '
                    : themeProvider.language == 'German'
                        ? 'Spielen gegen Freund'
                        : 'Play vs Friend',
                icon: Icons.group,
                onTap: () {
                  gameProvider.setVsComputer(value: false);
                  // navigate to setup game time screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameTimeScreen(),
                    ),
                  );
                },
              ),
                             buildGameType(
                lable:themeProvider.language == 'English'
                ? 'News'
                : themeProvider.language == 'فارسی'
                    ? 'اخبار'
                    : themeProvider.language == 'پشتو'
                    ? 'خبرونه'
                    : themeProvider.language == 'German'
                        ? 'Nachricht'
                        : 'News', 
                icon: Icons.newspaper,
                onTap: () {
                  // navigate to about screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreenn(),
                    ),
                  );
                },
                
              ),

              buildGameType(
                  lable: themeProvider.language == 'English'
                ? 'AFG National Players'
                : themeProvider.language == 'فارسی'
                    ? 'بازیکنان ملی افغانستان'
                    : themeProvider.language == 'پشتو'
                    ? 'د افغانستان ملي لوبغاړي'
                    : themeProvider.language == 'German'
                        ? 'AFG-Nationalspieler'
                        : 'AFG National Players',
                  icon: Icons.leaderboard ,
                  onTap: () {
                    // navigate to About Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerStatsScreen(),
                      ),
                    );
                  }),
              buildGameType(
                lable: themeProvider.language == 'English'
                ? 'Settings'
                : themeProvider.language == 'فارسی'
                    ? 'تنظیمات'
                    : themeProvider.language == 'پشتو'
                    ? 'ترتیبات'
                    : themeProvider.language == 'German'
                        ? 'Einstellungen'
                        : 'Sittings',
                icon: Icons.settings,
                onTap: () {
                  // navigate to settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
              buildGameType(
                lable: themeProvider.language == 'English'
                ? 'About'
                : themeProvider.language == 'فارسی'
                    ? 'در باره'
                    : themeProvider.language == 'پشتو'
                    ? 'په اړه'
                    : themeProvider.language == 'German'
                        ? 'Über'
                        : 'About',
                icon: Icons.info,
                onTap: () {
                  // navigate to about screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
                },
              ),
            //  buildGameType(
            //     lable: themeProvider.language == 'English'
            //     ? 'Play Offline'
            //     : themeProvider.language == 'فارسی'
            //         ? 'آفلاین بازی کنید'
            //         : themeProvider.language == 'پشتو'
            //             ? 'آفلاین ولوبیږئ'
            //             : themeProvider.language == 'German'
            //                 ? 'Offline spielen'
            //                 : 'Play Offline',
            //     icon: Icons.offline_bolt,
            //     onTap: () {
            //       // navigate directly to game screen for offline play
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const GameScreen(isCustomTime: false, gameTime: '00:00:00'),
            //         ),
            //       );
            //     },
            //   ),
              
            ],
          ),
        ),
      ),
    );
  }
}
