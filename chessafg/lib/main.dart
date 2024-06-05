import 'package:chessafg/Previous-games-screen.dart';
import 'package:chessafg/chess_game.dart';
import 'package:chessafg/main_screan/about_screan.dart';
import 'package:chessafg/main_screan/game_screan.dart';
import 'package:chessafg/main_screan/gametime_screaan.dart';
import 'package:chessafg/main_screan/main_homescrein.dart';
import 'package:chessafg/main_screan/settings_screan.dart';
import 'package:chessafg/provider/atuntication_provider.dart';
import 'package:chessafg/provider/game_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chessafg/authentication/landing_screen.dart';
import 'package:chessafg/authentication/login_screen.dart';
import 'package:chessafg/authentication/sign_up_screen.dart';
import 'package:chessafg/constants.dart';
import 'package:chessafg/firebase_options.dart';
import 'package:provider/provider.dart';
import 'news_screen.dart';
import 'admin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await signInAnonymously();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => GameProvider()),
      ChangeNotifierProvider(create: (_) => AuthenticationProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreenn(),
     initialRoute: Constants.loginScreen,
      routes: {
        Constants.homeScreen: (context) => const HomeScreen(),
        Constants.gameScreen: (context) => const GameScreen(),
        Constants.settingScreen: (context) => const SettingsScreen(),
        Constants.aboutScreen: (context) => const AboutScreen(),
        Constants.gameTimeScreen: (context) => const GameTimeScreen(),
        Constants.loginScreen: (context) => const LoginScreen(),
        Constants.signUpScreen: (context) => const SignUpScreen(),
        Constants.landingScreen: (context) => const LandingScreen(),
        
        Constants.homeScreenn: (context) =>HomeScreenn(),
       // Constants.previousGamesScreen: (context) =>PreviousGamesScreen(),

       // Constants.fogotPasswordMialScreen: (context) => const FogotPasswordMialScreen(),

      },
    );
  }
}
class HomeScreenn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },
              child: Text('View News'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text('Admin - Post News'),
            ),
          ],
        ),
      ),
    );
  }
}
Future<User?> signInAnonymously() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user;
  } catch (e) {
    print('Failed to sign in: $e');
    return null;
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   User? user = await signInAnonymously();
//   runApp(MyApp());
// }
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> saveGame(ChessGame game) async {
//     await _db.collection('games').doc(game.id).set(game.toMap());
//   }

//   Stream<List<ChessGame>> getUserGames(String userId) {
//     return _db.collection('games')
//       .where('player1', isEqualTo: userId)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => ChessGame.fromMap(doc.data() as Map<String, dynamic>, doc.id))
//           .toList());
//   }
// }