import 'package:chessafg/constants.dart';
import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/main_screan/game_start_up_screan.dart';
import 'package:chessafg/provider/game_provider.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameTimeScreen extends StatefulWidget {
  const GameTimeScreen({super.key});

  @override
  State<GameTimeScreen> createState() => _GameTimeScreenState();
}

class _GameTimeScreenState extends State<GameTimeScreen> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    print('VS VALUE: ${gameProvider.vsComputer}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(themeProvider.language == 'English'
              ? 'Choose Game time'
              : themeProvider.language == 'فارسی'
                  ? 'زمان بازی را انتخاب کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'د لوبې وخت وټاکئ'
                  : themeProvider.language == 'German'
                      ? 'Spielzeit wählen'
                      : 'Choose Game time',
          
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: gameTimes.length,
            itemBuilder: (context, index) {
              // get the first word of the game time
              final String lable = gameTimes[index].split(' ')[0];

              // gat the second word from game time
              final String gameTime = gameTimes[index].split(' ')[1];

              return buildGameType(
                lable: lable,
                gameTime: gameTime,
                onTap: () {
                  if (lable == Constants.custom) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameStartUpScreen(
                          isCustomTime: true,
                          gameTime: gameTime,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameStartUpScreen(
                          isCustomTime: false,
                          gameTime: gameTime,
                        ),
                      ),
                    );
                  }
                },
              );
            }),
      ),
    );
    
  }
}
