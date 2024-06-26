
// import 'package:chessafg/homescreenn.dart';
// import 'package:chessafg/main_screan/about_screan.dart';
// import 'package:chessafg/main_screan/game_screan.dart';
// import 'package:chessafg/main_screan/gametime_screaan.dart';
// import 'package:chessafg/main_screan/main_homescrein.dart';
// import 'package:chessafg/main_screan/settings_screan.dart';
// import 'package:chessafg/provider/atuntication_provider.dart';
// import 'package:chessafg/provider/game_provider.dart';
// import 'package:chessafg/provider/infomation/ThemeProvider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:chessafg/authentication/landing_screen.dart';
// import 'package:chessafg/authentication/login_screen.dart';
// import 'package:chessafg/authentication/sign_up_screen.dart';
// import 'package:chessafg/constants.dart';
// import 'package:chessafg/firebase_options.dart';
// import 'package:provider/provider.dart';
// import 'news_screen.dart';




// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await signInAnonymously();
//   runApp(
//     MultiProvider(providers: [
//       ChangeNotifierProvider(create: (_) => GameProvider()),
//       ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
//       ChangeNotifierProvider(create: (_) => ThemeProvider()),

//     ], child: const MyApp()),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: HomeScreenn(),
//      initialRoute: Constants.loginScreen,
//       routes: {
//         Constants.homeScreen: (context) => const HomeScreen(),
//         Constants.gameScreen: (context) => const GameScreen(),
//         Constants.settingsScreen: (context) => SettingsScreen(),
//         Constants.aboutScreen: (context) => const AboutScreen(),
//         Constants.gameTimeScreen: (context) => const GameTimeScreen(),
//         Constants.loginScreen: (context) => const LoginScreen(),
//         Constants.signUpScreen: (context) => const SignUpScreen(),
//         Constants.landingScreen: (context) => const LandingScreen(),
        
//         Constants.homeScreenn: (context) =>HomeScreenn(),
//         Constants.authGate:(context) => AuthGate(),

//       },
//     );
//   }
// }


// class AuthGate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           User? user = snapshot.data;
//           if (user == null) {
//             return SignInScreen();
//           } else {
//             return NewsScreen();
//           }
//         }
//         return Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }

// class SignInScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await FirebaseAuth.instance.signInAnonymously();
//           },
//           child: Text('Sign in anonymously'),
//         ),
//       ),
//     );
//   }
// }

// // class HomeScreenn extends StatelessWidget {


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('News App'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => NewsScreen()),
// //                 );
// //               },
// //               child: Text('View News'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => AdminScreen()),
// //                 );
// //               },
// //               child: Text('Admin - Post News'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// Future<User?> signInAnonymously() async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//     return userCredential.user;
//   } catch (e) {
//     print('Failed to sign in: $e');
//     return null;
//   }
// }



















// import 'package:chessafg/main_screan/change_password_screen.dart';
// import 'package:chessafg/news_screen.dart';
// import 'package:chessafg/provider/game_provider.dart';
// import 'package:chessafg/provider/infomation/ThemeProvider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'firebase_options.dart';

// import 'homescreenn.dart';
// import 'main_screan/about_screan.dart';
// import 'main_screan/game_screan.dart';
// import 'main_screan/gametime_screaan.dart';
// import 'main_screan/main_homescrein.dart';
// import 'main_screan/settings_screan.dart';
// import 'provider/atuntication_provider.dart';
// import 'authentication/landing_screen.dart';
// import 'authentication/login_screen.dart';
// import 'authentication/sign_up_screen.dart';
// import 'constants.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await signInAnonymously();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => GameProvider()),
//         ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       themeMode: themeProvider.themeMode,
//       theme: ThemeData(
//         textTheme: TextTheme(
//           bodyText1: TextStyle(fontSize: themeProvider.textSize),
//           bodyText2: TextStyle(fontSize: themeProvider.textSize),
//         ),
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData(
//         textTheme: TextTheme(
//           bodyText1: TextStyle(fontSize: themeProvider.textSize),
//           bodyText2: TextStyle(fontSize: themeProvider.textSize),
//         ),
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//           brightness: Brightness.dark,
//         ),
//         useMaterial3: true,
//       ),
//       home: HomeScreenn(),
//       initialRoute: Constants.loginScreen,
//       routes: {
//         Constants.homeScreen: (context) => const HomeScreen(),
//         Constants.gameScreen: (context) => const GameScreen(),
//         Constants.settingsScreen: (context) => SettingsScreen(),
//         Constants.aboutScreen: (context) => AboutScreen(),
//         Constants.gameTimeScreen: (context) => const GameTimeScreen(),
//         Constants.loginScreen: (context) => const LoginScreen(),
//         Constants.signUpScreen: (context) => const SignUpScreen(),
//         Constants.landingScreen: (context) => const LandingScreen(),
//         Constants.homeScreenn: (context) => HomeScreenn(),
//         Constants.authGate: (context) => AuthGate(),
//          Constants.changePasswordScreen: (context) => ChangePasswordScreen(),
//       },
//     );
//   }
// }

// class AuthGate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           User? user = snapshot.data;
//           if (user == null) {
//             return SignInScreen();
//           } else {
//             return NewsScreen();
//           }
//         }
//         return Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }

// class SignInScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await FirebaseAuth.instance.signInAnonymously();
//           },
//           child: Text('Sign in anonymously'),
//         ),
//       ),
//     );
//   }
// }

// Future<User?> signInAnonymously() async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//     return userCredential.user;
//   } catch (e) {
//     print('Failed to sign in: $e');
//     return null;
//   }
// }













import 'package:chessafg/main_screan/change_password_screen.dart';
import 'package:chessafg/main_screan/user_data_screen.dart';
import 'package:chessafg/news_screen.dart';
import 'package:chessafg/provider/game_provider.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
//import 'package:chessafg/provider/infomation/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'homescreenn.dart';
import 'main_screan/about_screan.dart';
import 'main_screan/game_screan.dart';
import 'main_screan/gametime_screaan.dart';
import 'main_screan/main_homescrein.dart';
import 'main_screan/settings_screan.dart';
import 'provider/atuntication_provider.dart';
import 'authentication/landing_screen.dart';
import 'authentication/login_screen.dart';
import 'authentication/sign_up_screen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await signInAnonymously();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: themeProvider.textSize),
          bodyText2: TextStyle(fontSize: themeProvider.textSize),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: themeProvider.textSize),
          bodyText2: TextStyle(fontSize: themeProvider.textSize),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomeScreenn(),
      initialRoute: Constants.landingScreen,
      routes: {
        Constants.homeScreen: (context) => const HomeScreen(),
        Constants.gameScreen: (context) => const GameScreen(),
        Constants.settingsScreen: (context) => SettingsScreen(),
        Constants.aboutScreen: (context) => AboutScreen(),
        Constants.gameTimeScreen: (context) => const GameTimeScreen(),
        Constants.loginScreen: (context) => const LoginScreen(),
        Constants.signUpScreen: (context) => const SignUpScreen(),
        Constants.landingScreen: (context) => const LandingScreen(),
        Constants.homeScreenn: (context) => HomeScreenn(),
        Constants.authGate: (context) => AuthGate(),
        Constants.changePasswordScreen: (context) => ChangePasswordScreen(),
        Constants.userDataScreen: (context) => UserDataScreen(),

      },
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          } else {
            return NewsScreen();
          }
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signInAnonymously();
          },
          child: Text('Sign in anonymously'),
        ),
      ),
    );
  }
}

Future<User?> signInAnonymously() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user;
  } catch (e) {
    print('Failed to sign in: $e');
    return null;
  }
}
