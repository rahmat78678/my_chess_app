import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:chessafg/widgwts/main_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:chessafg/widgwts/widgets.dart';
import 'package:provider/provider.dart';

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
        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showSnackBar(context: context, content:themeProvider.language == 'English'
              ? 'Password reset link sent to $email'
              : themeProvider.language == 'فارسی'
                  ? 'پیوند بازنشانی رمز عبور به $email ارسال شد'
                  : themeProvider.language == 'پشتو'
                  ? 'د پټنوم بیا تنظیم کولو لینک $email بریښنالیک ته لیږل شوی '
                  : themeProvider.language == 'German'
                      ? 'Link zum Zurücksetzen des Passworts an $email gesendet'
                      : 'Password reset link sent to $email');//پیوند بازنشانی رمز عبور به $email ارسال شد
      } on FirebaseAuthException catch (e) {
        showSnackBar(context: context, content: e.message ?? 'An error occurred');//خطایی رخ داد
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(themeProvider.language == 'English'
              ? 'forget password'
              : themeProvider.language == 'فارسی'
                  ?'فراموشی رمز عبور'
                  : themeProvider.language == 'پشتو'
                  ? 'پټنوم هیر کړئ '
                  : themeProvider.language == 'German'
                      ? 'Passwort vergessen'
                      : 'forget password'),
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
                
                Text(themeProvider.language == 'English'
              ? 'Enter your email to receive a password reset link'
              : themeProvider.language == 'فارسی'
                  ? 'برای دریافت لینک بازنشانی رمز عبور ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'د پټنوم بیا تنظیم کولو لینک ترلاسه کولو لپاره خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben Sie Ihre E-Mail-Adresse ein, um einen Link zum Zurücksetzen des Passworts zu erhalten'
                      : 'Enter your email to receive a password reset link',//'ایمیل خود را برای دریافت پیوند بازنشانی رمز عبور وارد کنید'،
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textFormDecoration.copyWith(
                      labelText: themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email',
                        hintText: 
                       themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email',                        
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 
                       themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email';//'لطفا آدرس اییمیل خود را وارد نمایید؛                
                       } else if (!validateEmail(value)) {
                      return themeProvider.language == 'English'
              ? 'Please enter a valid email'
              : themeProvider.language == 'فارسی'
                  ? ' لطفا یک ایمیل معتبر وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ یو باوري بریښنالیک ولیکئ'
                  : themeProvider.language == 'German'
                      ? 'Bitte geben Sie eine gültige Email-Adresse ein'
                      : 'Please enter a valid email';
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
                  lable:themeProvider.language == 'English'
              ? 'Send reset link'
              : themeProvider.language == 'فارسی'
                  ?  'ارسال لینک بازنشانی'
                  : themeProvider.language == 'پشتو'
                  ? 'د بیا تنظیم کولو لینک واستوئ'
                  : themeProvider.language == 'German'
                      ? 'Link zum Zurücksetzen senden'
                      :'Send reset link',
  
                
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
