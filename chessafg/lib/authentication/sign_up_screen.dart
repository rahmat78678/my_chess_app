import 'dart:io';

import 'package:chessafg/halper/halper_metods.dart';
import 'package:chessafg/models/user_model.dart';
import 'package:chessafg/provider/atuntication_provider.dart';
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:chessafg/service/assets_manager.dart';
import 'package:chessafg/widgwts/main_auth_button.dart';
import 'package:chessafg/widgwts/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  File? finalFileImage;
  String fileImageUrl = '';
  late String name;
  late String email;
  late String password;
  bool obscureText = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void selectImage({required bool fromCamera}) async {
    finalFileImage = await pickImage(
        fromCamera: fromCamera,
        onFail: (e) {
          // show error message
          showSnackBar(context: context, content: e.toString());
        });

    if (finalFileImage != null) {
      cropImage(finalFileImage!.path);
    } else {
      popCropDialog();
    }
  }

  void cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      maxHeight: 800,
      maxWidth: 800,
    );

    popCropDialog();

    if (croppedFile != null) {
      setState(() {
        finalFileImage = File(croppedFile.path);
      });
    } else {
      popCropDialog();
    }
  }

  void popCropDialog() {
    Navigator.pop(context);
  }

  void showImagePickerDialog() {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              themeProvider.language == 'English'
              ? 'Select an Option'
              : themeProvider.language == 'فارسی'
                  ? 'یک گزینه را انتخاب کنید'
                  : themeProvider.language == 'پشتو'
                  ? ' یو اختیار غوره کړئ '
                  : themeProvider.language == 'German'
                      ? 'Wähle eine Option'
                      : 
                      'Select an Option',
              ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title:  Text(
                    themeProvider.language == 'English'
              ? 'Camera'
              : themeProvider.language == 'فارسی'
                  ? 'دوربین'
                  : themeProvider.language == 'پشتو'
                  ? 'کیمره'
                  : themeProvider.language == 'German'
                      ? 'Kamera'
                      :
                       'Camera',
                    ),
                  onTap: () {
                    // choose image from camera
                    selectImage(fromCamera: true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(
                    themeProvider.language == 'English'
              ? 'Gallery'
              : themeProvider.language == 'فارسی'
                  ? 'آلبوم عکس'
                  : themeProvider.language == 'پشتو'
                  ? 'ګالری'
                  : themeProvider.language == 'German'
                      ? 'Galerie'
                      : 
                      'Gallery',
                    ),
                  onTap: () {
                    // choose image from gallery
                    selectImage(fromCamera: false);
                  },
                ),
              ],
            ),
          );
        });
  }

  // signUp user
   void signUpUser() async {
  final authProvider = context.read<AuthenticationProvider>();
   final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    UserCredential? userCredential =
        await authProvider.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential != null) {
      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              themeProvider.language == 'English'
              ? 'Email verification'
              : themeProvider.language == 'فارسی'
                  ? 'تأیید ایمیل'
                  : themeProvider.language == 'پشتو'
                  ? 'تأیید ایمیل'
                  : themeProvider.language == 'German'
                      ? 'Bestätigungsemail'
                      :
                       'Email verification',
            )
              ,
            content: Text( 
              themeProvider.language == 'English'
              ? '"A verification email has been sent to ${user.email}. Please verify your email."'
              : themeProvider.language == 'فارسی'
                  ? "ایمیل تأیید به ${user.email} ارسال شد. لطفاً ایمیل خود را تأیید کنید."
                  : themeProvider.language == 'پشتو'
                  ? "${user.email} ته د تایید بریښنالیک لیږل شوی. مهرباني وکړئ خپل بریښنالیک تایید کړئ."
                  : themeProvider.language == 'German'
                      ? "Eine Bestätigungs-E-Mail wurde an ${user.email} gesendet. Bitte bestätigen Sie Ihre E-Mail."
                      : 
                      "A verification email has been sent to ${user.email}. Please verify your email.",),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  themeProvider.language == 'English'
              ? 'OK'
              : themeProvider.language == 'فارسی'
                  ? 'قبول'
                  : themeProvider.language == 'پشتو'
                  ? ' منل کېدل'
                  : themeProvider.language == 'German'
                      ? 'OK'
                      :
                       'OK',),
              ),
            ],
          ),
        );
      }

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        image: '',
        createdAt: '',
        playerRating: 1200,
      );

      authProvider.saveUserDataToFireStore(
        currentUser: userModel,
        fileImage: finalFileImage,
        onSuccess: () async {
          formKey.currentState!.reset();
          showSnackBar(context: context, content:
          themeProvider.language == 'English'
              ? 'Registration successful, please login.'
              : themeProvider.language == 'فارسی'
                  ? 'قبول'
                  : themeProvider.language == 'پشتو'
                  ? 'رجسټریشن بریالی شو، مهرباني وکړئ ننوتئ. '
                  : themeProvider.language == 'German'
                      ? 'Registrierung erfolgreich, bitte melden Sie sich an.'
                      : 
                      'Registration successful, please login.', );

          await authProvider.signOutUser().whenComplete(() {
            Navigator.pop(context);
          });
        },
        onFail: (error) {
          showSnackBar(context: context, content: error.toString());
        },
      );
    }
  } else {
    showSnackBar(context: context, content: 
    themeProvider.language == 'English'
              ? 'Please fill in all fields'
              : themeProvider.language == 'فارسی'
                  ? 'لطفاً همه فیلدها را پر کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'ترتیبات'
                  : themeProvider.language == 'German'
                      ? 'Bitte füllen Sie alle Felder aus'
                      : 
                      'Please fill in all fields',);
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
                 Text(
                  themeProvider.language == 'English'
              ? 'Sign Up'
              : themeProvider.language == 'فارسی'
                  ? 'ثبت نام'
                  : themeProvider.language == 'پشتو'
                  ? 'ګډون کول '
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign Up',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                finalFileImage != null
                    ? Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                            backgroundImage:
                                FileImage(File(finalFileImage!.path)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(35)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // pick image from camera or galery
                                    showImagePickerDialog();
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage(AssetsManager.userIcon),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(35)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // pick image from camera or galery
                                    showImagePickerDialog();
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 25,
                  maxLines: 1,
                  decoration: textFormDecoration.copyWith(
                    counterText: '',
                    labelText: themeProvider.language == 'English'
              ? 'Enter your name'
              : themeProvider.language == 'فارسی'
                  ? 'اسم تان را وارد کن'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل نوم ولیکئ'
                  : themeProvider.language == 'German'
                      ? 'Gib deinen Namen ein'
                      : 'Enter your name',
                    hintText: themeProvider.language == 'English'
              ? 'Enter your name'
              : themeProvider.language == 'فارسی'
                  ? 'اسم تان را وارد کن'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل نوم ولیکئ'
                  : themeProvider.language == 'German'
                      ? 'Gib deinen Namen ein'
                      : 'Enter your name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return themeProvider.language == 'English'
              ? 'Enter your name'
              : themeProvider.language == 'فارسی'
                  ? 'اسم تان را وارد کن'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل نوم ولیکئ'
                  : themeProvider.language == 'German'
                      ? 'Gib deinen Namen ein'
                      : 'Enter your name';
                    } else if (value.length < 3) {
                      return themeProvider.language == 'English'
              ? 'Name must be atleast 3 characters'
              : themeProvider.language == 'فارسی'
                  ? 'نام باید حداقل 3 حروف باشد'
                  : themeProvider.language == 'پشتو'
                  ? 'نوم باید لږ تر لږه 3 حروف وي'
                  : themeProvider.language == 'German'
                      ? 'Der Name muss mindestens 3 Zeichen lang sein'
                      : 'Name must be atleast 3 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value.trim();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  decoration: textFormDecoration.copyWith(
                    labelText: themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email'  ,
                    hintText: themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email'  ,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return themeProvider.language == 'English'
              ? 'Enter your email'
              : themeProvider.language == 'فارسی'
                  ? ' ایمیل خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل بریښنالیک دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre E-Mail Adresse ein'
                      : 'Enter your email'  ;
                    } else if (!validateEmail(value)) {
                      return themeProvider.language == 'English'
              ? 'Please enter a valid email'
              : themeProvider.language == 'فارسی'
                  ? ' لطفا یک ایمیل معتبر وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ یو باوري بریښنالیک ولیکئ'
                  : themeProvider.language == 'German'
                      ? 'Bitte geben Sie eine gültige Email-Adresse ein'
                      : 'Please enter a valid email';;
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
                  textInputAction: TextInputAction.done,
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
                    hintText: themeProvider.language == 'English'
              ? 'Enter your password'
              : themeProvider.language == 'فارسی'
                  ? ' کلمه عبور خود را وارد کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'خپل رمز دننه کړئ'
                  : themeProvider.language == 'German'
                      ? 'Geben sie ihre Passwort ein'
                      : 'Enter your password',
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
                      : 'Enter your password';
                    } else if (value.length < 8) {
                      return themeProvider.language == 'English'
              ? 'Password must be at least 8 characters long'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور باید حداقل 8 کاراکتر باشد.'
                  : themeProvider.language == 'پشتو'
                  ? 'پاسورډ باید لږ تر لږه ۸ حروف اوږد وي'
                  : themeProvider.language == 'German'
                      ? 'Das Passwort muss mindestens 8 Zeichen lang sein.'
                      : 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : MainAuthButton(
                        lable: themeProvider.language == 'English'
              ? 'Sign Up'
              : themeProvider.language == 'فارسی'
                  ? 'ثبت نام'
                  : themeProvider.language == 'پشتو'
                  ? 'ګډون کول '
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign Up',
                        onPressed: () {
                          // login the user with Email and password
                          signUpUser();
                        },
                        fontSize: 24.0,
                      ),
                const SizedBox(
                  height: 40,
                ),
                HaveAccountWidget(
                  label: themeProvider.language == 'English'
              ? ' Have an account?'
              : themeProvider.language == 'فارسی'
                  ? 'حساب  دارید؟'
                  : themeProvider.language == 'پشتو'
                  ? ' حساب  لرئ؟ '
                  : themeProvider.language == 'German'
                      ? 'Haben sie Konto?'
                      : ' Have an account?',
                  labelAction: themeProvider.language == 'English'
              ? 'Sign In'
              : themeProvider.language == 'فارسی'
                  ? 'ورود'
                  : themeProvider.language == 'پشتو'
                  ?'ننوزئ'
                  : themeProvider.language == 'German'
                      ? 'Anmelden'
                      : 'Sign In',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
