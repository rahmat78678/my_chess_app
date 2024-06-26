import 'package:chessafg/constants.dart';
import 'package:chessafg/provider/atuntication_provider.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // check authenticationState - if isSignedIn or not
  void checkAuthenticationState() async {
    final authProvider = context.read<AuthenticationProvider>();

    if (await authProvider.checkIsSignedIn()) {
       
      // 1. get user data from firestore
      await authProvider.getUserDataFromFireStore();

      // 2. save user data to shared preferences
      await authProvider.saveUserDataToSharedPref();

      // 3. navigate to home screen
     navigate(isSignedIn: true);
     
      
     // Navigator.pushReplacementNamed(context, Constants.homeScreen);
    } else {
      // navigate to the sign screen
      navigate(isSignedIn: false);
       
      //  Navigator.pushNamedAndRemoveUntil(
      //           context, Constants.homeScreen, (route) => false);
    }
  }

  @override
  void initState() {
    checkAuthenticationState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage(AssetsManager.chessIcon),
        ),
      ),
    );
  }

  void navigate({required bool isSignedIn}) {
    if (isSignedIn) {
      Navigator.pushReplacementNamed(context, Constants.homeScreen);

    } else {
      Navigator.pushReplacementNamed(context, Constants.loginScreen);
    }
  }
}
