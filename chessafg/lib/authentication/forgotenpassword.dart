import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/widgwts/main_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:chessafg/widgwts/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email;

  void sendPasswordResetEmail() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showSnackBar(context: context, content:'Password reset link sent to $email');//پیوند بازنشانی رمز عبور به $email ارسال شد
      } on FirebaseAuthException catch (e) {
        showSnackBar(context: context, content: e.message ?? 'An error occurred');//خطایی رخ داد
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forget password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AssetsManager.chessIcon),
                ),
                const SizedBox(height: 20),
               const Text('Enter your email to receive a password reset link',//'ایمیل خود را برای دریافت پیوند بازنشانی رمز عبور وارد کنید'،
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textFormDecoration.copyWith(
                      labelText: 'Enter your email',
                        hintText: 
                        'Enter your email',                        
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 
                       'please enter your Email';//'لطفا آدرس اییمیل خود را وارد نمایید؛                
                       } else if (!validateEmail(value)) {
                      return 
                      'Please enter a valid email' ;
                    } else if (validateEmail(value)) {
                      return null;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value.trim();
                  },
                ),
                const SizedBox(height: 20),
                MainAuthButton(
                  lable:
                  'ارسال لینک بازنشانی'
                  ,
                  onPressed: sendPasswordResetEmail,
                  fontSize: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
