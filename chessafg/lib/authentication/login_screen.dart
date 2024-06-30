

import 'package:chessafg/authentication/forgotenpassword.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chessafg/constants.dart';
import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/provider/atuntication_provider.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:chessafg/widgwts/main_auth_button.dart';
import 'package:chessafg/widgwts/social_buton.dart';
import 'package:chessafg/widgwts/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  late String email;
  late String password;
  bool obscureText = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void signInUser() async {
    final authProvider = context.read<AuthenticationProvider>();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      UserCredential? userCredential =
          await authProvider.signInUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        User? user = userCredential.user;

        if (user != null && user.emailVerified) {
          // 1. بررسی اینکه آیا این کاربر در فایراستور وجود دارد
          bool userExist = await authProvider.checkUserExist();

          if (userExist) {
            // 2. دریافت داده‌های کاربر از فایراستور
            await authProvider.getUserDataFromFireStore();

            // 3. ذخیره داده‌های کاربر در حافظه محلی
            await authProvider.saveUserDataToSharedPref();

            // 4. ذخیره این کاربر به عنوان وارد شده
            await authProvider.setSignedIn();

            formKey.currentState!.reset();

            authProvider.setIsLoading(value: false);

            // 5. هدایت به صفحه اصلی
            navigate(isSignedIn: true);
          } else {
            // TODO هدایت به صفحه اطلاعات کاربر
            navigate(isSignedIn: false);
          }
        } else {
          final themeProvider = Provider.of<ThemeProvider>(context);

          showDialog(
            context: context,
            
            builder: (context) => AlertDialog(
              
              title: Text( themeProvider.language == 'English'
              ? "Email Confirmation"
              : themeProvider.language == 'فارسی'
                  ?"تأیید ایمیل"
                  : themeProvider.language == 'پشتو'
                  ? "د بریښنالیک تایید"
                  : themeProvider.language == 'German'
                      ? "Email Bestätigung"
                      : "Email Confirmation"
               
                ),
              content:  Text(
                themeProvider.language == 'English'
              ? 'Your email has not been verified. Please verify your email.'
              : themeProvider.language == 'فارسی'
                  ? "ایمیل شما تایید نشده است. لطفا ایمیل خود را تایید کنید."
                  : themeProvider.language == 'پشتو'
                  ?"ستاسو بریښنالیک نه دی تایید شوی. مهرباني وکړئ خپل بریښنالیک تایید کړئ."
                  : themeProvider.language == 'German'
                      ? 'Ihre E-Mail wurde nicht bestätigt. Bitte bestätigen Sie Ihre E-Mail.'
                      : 'Your email has not been verified. Please verify your email.',
               //ایمیل شما تأیید نشده است. لطفاً ایمیل خود را تأیید کنید             
             ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text( themeProvider.language == 'English'
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
            ),
          );
        }
      }
    } else {
      final themeProvider = Provider.of<ThemeProvider>(context);

      showSnackBar(context: context, content: 
      themeProvider.language == 'English'
              ? 'Please fill in all fields'  
              : themeProvider.language == 'فارسی'
                  ? 'لطفا همه موارد را پر کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ ټولې ساحې ډکې کړئ'
                  : themeProvider.language == 'German'
                      ? 'Bitte füllen Sie alle Felder aus'
                      : 'Please fill in all fields'  ,
    
);
    }
  }

  navigate({required bool isSignedIn}) {
    if (isSignedIn) {
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.homeScreen, (route) => false);
    } else {
      // هدایت به صفحه اطلاعات کاربر
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
       final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    
                    radius: 50,
                    backgroundImage: AssetImage(AssetsManager.icon),
                  ),
                  
                  Text(
                    themeProvider.language == 'English'
              ? 'Sign In'
              : themeProvider.language == 'فارسی'
                  ? 'ورود'
                  : themeProvider.language == 'پشتو'
                  ?'ننوزئ'
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign In',
                    //'ورود'
                    
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                      : 'Enter your email'    //'لطفا ایمیل خود را وارد کنید'
                        ;
                      } else if (!validateEmail(value)) {
                        return 
                        themeProvider.language == 'English'
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textFormDecoration.copyWith(
                      labelText: themeProvider.language == 'English'
              ? 'Enter your password'
              : themeProvider.language == 'فارسی'
                  ? ' کلمه عبور خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل رمز دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre Passwort ein'
                      : 'Enter your password',
                        hintText: 
                       themeProvider.language == 'English'
              ? 'Enter your password'
              : themeProvider.language == 'فارسی'
                  ? ' کلمه عبور خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل رمز دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre Passwort ein'
                      : 'Enter your password',     //'رمز عبور خود را وارد کنید',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return themeProvider.language == 'English'
              ? 'Enter your password'
              : themeProvider.language == 'فارسی'
                  ? ' کلمه عبور خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل رمز دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre Passwort ein'
                      : 'Enter your password';//'لطفا یک رمز عبور وارد کنید';
                      } else if (value.length < 8) {
                        return themeProvider.language == 'English'
              ? 'Password must be at least 8 characters long'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور باید حداقل 8 کاراکتر باشد.'
                  : themeProvider.language == 'پشتو'
                  ? 'پاسورډ باید لږ تر لږه ۸ حروف اوږد وي'
                  : themeProvider.language == 'German'
                      ? 'Das Passwort muss mindestens 8 Zeichen lang sein.'
                      : 'Password must be at least 8 characters long'
                        
                        ;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        themeProvider.language == 'English'
              ? 'forget password?'
              : themeProvider.language == 'فارسی'
                  ?'?فراموشی رمز عبور'
                  : themeProvider.language == 'پشتو'
                  ? '?پټنوم هیر کړئ '
                  : themeProvider.language == 'German'
                      ? 'Passwort vergessen?'
                      : 'forget password?'//'فراموشی رمز عبور؟'
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : MainAuthButton(
                          lable: themeProvider.language == 'English'
              ? 'Sign In'
              : themeProvider.language == 'فارسی'
                  ? 'ورود'
                  : themeProvider.language == 'پشتو'
                  ?'ننوزئ'
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign In',//'ورود'
                          
                          onPressed: signInUser,
                          fontSize: 24.0,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                   Text(themeProvider.language == 'English'
              ?  'Sign In with \n -OR-'
              : themeProvider.language == 'فارسی'
                  ? 'ورود به سیستم با'
                  : themeProvider.language == 'پشتو'
                  ?'سره ننوتل '
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      :  'Sign In with \n -OR-',
                   //'- یا - \n ورود با'
                    
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        label: themeProvider.language == 'English'
              ? 'Guest'
              : themeProvider.language == 'فارسی'
                  ? 'مهمان'
                  : themeProvider.language == 'پشتو'
                  ? ' مهمان'
                  : themeProvider.language == 'German'
                      ? 'Gast'
                      : 'Guest'//'مهمان'
                        ,
                        assetImage: AssetsManager.userIcon,
                        height: 55.0,
                        width: 55.0,
                        onTap: () {},
                      ),
                      SocialButton(
                        label:themeProvider.language == 'English'
              ? 'Google'
              : themeProvider.language == 'فارسی'
                  ? 'گوگل'
                  : themeProvider.language == 'پشتو'
                  ? ' گوگل'
                  : themeProvider.language == 'German'
                      ? 'Google'
                      : 'Google'//'گوگل'
                        ,
                        assetImage: AssetsManager.googleIcon,
                        height: 55.0,
                        width: 55.0,
                        onTap: () {},
                      ),
                      SocialButton(
                        label:themeProvider.language == 'English'
              ? 'Facebook'
              : themeProvider.language == 'فارسی'
                  ? 'فیسبوک'
                  : themeProvider.language == 'پشتو'
                  ? ' فیسبوک '
                  : themeProvider.language == 'German'
                      ? 'Facebook'
                      : 'Facebook' //'فیسبوک'
                        ,
                        assetImage: AssetsManager.facebookLogo,
                        height: 55.0,
                        width: 55.0,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  HaveAccountWidget(
                    label: themeProvider.language == 'English'
              ? 'Dont have an account?'
              : themeProvider.language == 'فارسی'
                  ? 'حساب  ندارید؟'
                  : themeProvider.language == 'پشتو'
                  ? ' حساب نه لرئ؟ '
                  : themeProvider.language == 'German'
                      ? 'Sie haben noch kein Konto?'
                      : 'Dont have an account?'
                    ,
                    labelAction:themeProvider.language == 'English'
              ? 'Sign Up'
              : themeProvider.language == 'فارسی'
                  ? 'ثبت نام'
                  : themeProvider.language == 'پشتو'
                  ? 'ګډون کول '
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign Up'//'ثبت نام'
                    ,
                    onPressed: () {
                      Navigator.pushNamed(context, Constants.signUpScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
