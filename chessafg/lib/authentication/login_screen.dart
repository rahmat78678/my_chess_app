// import 'package:chessafg/constants.dart';
// import 'package:chessafg/halper/halper_metods.dart';
// import 'package:chessafg/provider/atuntication_provider.dart';
// import 'package:chessafg/service/assets_manager.dart';
// import 'package:chessafg/widgwts/main_auth_button.dart';
// import 'package:chessafg/widgwts/social_buton.dart';
// import 'package:chessafg/widgwts/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late String email;
//   late String password;
//   bool obscureText = true;

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   // signIn user
//   void signInUser() async {
//   final authProvider = context.read<AuthenticationProvider>();
//   if (formKey.currentState!.validate()) {
//     formKey.currentState!.save();

//     UserCredential? userCredential =
//         await authProvider.signInUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     if (userCredential != null) {
//       User? user = userCredential.user;

//       if (user != null && user.emailVerified) {
//         // 1. check if this user exist in firestore
//         bool userExist = await authProvider.checkUserExist();

//         if (userExist) {
//           // 2. get user data from firestore
//           await authProvider.getUserDataFromFireStore();

//           // 3. save user data to shared preferenced - local storage
//           await authProvider.saveUserDataToSharedPref();

//           // 4. save this user as signed in
//           await authProvider.setSignedIn();

//           formKey.currentState!.reset();

//           authProvider.setIsLoading(value: false);

//           // 5. navigate to home screen
//           navigate(isSignedIn: true);
//         } else {
//           // TODO navigate to user information
//           navigate(isSignedIn: false);
//         }
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("تأیید ایمیل"),
//             content: Text("ایمیل شما تأیید نشده است. لطفاً ایمیل خود را تأیید کنید."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("باشه"),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   } else {
//     showSnackBar(context: context, content: 'لطفاً همه فیلدها را پر کنید');
//   }
// }

//   // void signInUser() async {
//   //   final authProvider = context.read<AuthenticationProvider>();
//   //   if (formKey.currentState!.validate()) {
//   //     // save the form
//   //     formKey.currentState!.save();

//   //     UserCredential? userCredential =
//   //         await authProvider.signInUserWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );

//   //     if (userCredential != null) {
//   //       // 1. check if this user exist in firestore
//   //       bool userExist = await authProvider.checkUserExist();

//   //       if (userExist) {
//   //         // 2. get user data from firestore
//   //         await authProvider.getUserDataFromFireStore();

//   //         // 3. save user data to shared preferenced - local storage
//   //         await authProvider.saveUserDataToSharedPref();

//   //         // 4. save this user as signed in
//   //         await authProvider.setSignedIn();

//   //         formKey.currentState!.reset();

//   //         authProvider.setIsLoading(value: false);

//   //         // 5. navigate to home screen
//   //         navigate(isSignedIn: true);
//   //       } else {
//   //         // TODO navigate to user information
//   //         navigate(isSignedIn: false);
//   //       }
//   //     }
//   //   } else {
//   //     showSnackBar(context: context, content: 'Please fill all fields');
//   //   }
//   // }

//   navigate({required bool isSignedIn}) {
//     if (isSignedIn) {
//       Navigator.pushNamedAndRemoveUntil(
//           context, Constants.homeScreen, (route) => false);
//     } else {
//       // navigate to user information screen
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = context.watch<AuthenticationProvider>();
//     return Scaffold(
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 15,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage(AssetsManager.chessIcon),
//                 ),
//                 const Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextFormField(
//                   decoration: textFormDecoration.copyWith(
//                       labelText: 'Enter your email',
//                       hintText: 'Enter your email'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!validateEmail(value)) {
//                       return 'Please enter a valid email';
//                     } else if (validateEmail(value)) {
//                       return null;
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     email = value.trim();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   decoration: textFormDecoration.copyWith(
//                     labelText: 'Enter your password',
//                     hintText: 'Enter your password',
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           obscureText = !obscureText;
//                         });
//                       },
//                       icon: Icon(
//                         obscureText ? Icons.visibility_off : Icons.visibility,
//                       ),
//                     ),
//                   ),
//                   obscureText: obscureText,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a password';
//                     } else if (value.length < 8) {
//                       return 'Password must be atleast 8 characters';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     password = value;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                      // forgot password
//                     },
//                     child: const Text('Forgot Password?'),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 authProvider.isLoading
//                     ? const CircularProgressIndicator()
//                     : MainAuthButton(
//                         lable: 'LOGIN',
//                         onPressed: signInUser,
//                         fontSize: 24.0,
//                       ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   '- OR - \n Sign in With',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SocialButton(
//                       label: 'Guest',
//                       assetImage: AssetsManager.userIcon,
//                       height: 55.0,
//                       width: 55.0,
//                       onTap: () {},
//                     ),
//                     SocialButton(
//                       label: 'Google',
//                       assetImage: AssetsManager.googleIcon,
//                       height: 55.0,
//                       width: 55.0,
//                       onTap: () {},
//                     ),
//                     SocialButton(
//                       label: 'Facebook',
//                       assetImage: AssetsManager.facebookLogo,
//                       height: 55.0,
//                       width: 55.0,
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 HaveAccountWidget(
//                   label: 'Don\'t have an account?',
//                   labelAction: 'Sign Up',
//                   onPressed: () {
//                     // navigate to sign up screen
//                     Navigator.pushNamed(context, Constants.signUpScreen);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }






import 'package:chessafg/authentication/forgotenpassword.dart';
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title:const Text( 
               "Email Confirmation"// "تأیید ایمیل"
                ),
              content:const  Text(
             "Your email has not been verified. Please verify your email."  //ایمیل شما تأیید نشده است. لطفاً ایمیل خود را تأیید کنید             
             ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const Text( "ok"//"باشه"
                  ),
                ),
              ],
            ),
          );
        }
      }
    } else {
      showSnackBar(context: context, content: 
'Please fill in all fields'      
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
                    backgroundImage: AssetImage(AssetsManager.chessIcon),
                  ),
                  const Text(
                    'Sign In'//'ورود'
                    ,
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Enter your email',//'ایمیل خود را وارد کنید',
                      hintText: 'Enter your email',//'ایمیل خود را وارد کنید',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 
                        'please enter your Email'//'لطفا ایمیل خود را وارد کنید'
                        ;
                      } else if (!validateEmail(value)) {
                        return 
                        'Please enter a valid email'//'لطفا یک ایمیل معتبر وارد کنید'
                        ;
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
                      labelText: 'Please enter the Password',//'رمز عبور خود را وارد کنید',
                      hintText: 'Please enter the Password',//'رمز عبور خود را وارد کنید',
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
                        return 'Please enter the Password';//'لطفا یک رمز عبور وارد کنید';
                      } else if (value.length < 8) {
                        return 
                        'Password must be at least 8 characters long.'//'رمز عبور باید حداقل 8 کاراکتر باشد'
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
                      child: const Text(
                        'forget password?'//'فراموشی رمز عبور؟'
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : MainAuthButton(
                          lable: 'Sign In'//'ورود'
                          ,
                          onPressed: signInUser,
                          fontSize: 24.0,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign In with \n -OR-'//'- یا - \n ورود با'
                    ,
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
                        label: 'مهمان'//'مهمان'
                        ,
                        assetImage: AssetsManager.userIcon,
                        height: 55.0,
                        width: 55.0,
                        onTap: () {},
                      ),
                      SocialButton(
                        label: 'Google'//'گوگل'
                        ,
                        assetImage: AssetsManager.googleIcon,
                        height: 55.0,
                        width: 55.0,
                        onTap: () {},
                      ),
                      SocialButton(
                        label: 'Facebook'//'فیسبوک'
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
                    label: 
                    'Dont have an account?'//'حساب کاربری ندارید؟'
                    ,
                    labelAction: 'Sign Up'//'ثبت نام'
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
