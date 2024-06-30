
import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}


class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  
  
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isProcessing = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      _isProcessing = true;
    });

    try {
      // Ensure new password and confirm password match
      if (_newPasswordController.text != _confirmPasswordController.text) {
        throw FirebaseAuthException(
          code:themeProvider.language == 'English'
              ? 'passwords-not-matching'
              : themeProvider.language == 'فارسی'
                  ? 'گذرواژه‌ها مطابقت ندارند'
                  : themeProvider.language == 'پشتو'
                  ? 'پاسورډونه - نه سمون خوري'
                  : themeProvider.language == 'German'
                      ? 'Passwörter stimmen nicht überein'
                      : 'passwords-not-matching', 
          message:themeProvider.language == 'English'
              ? 'New password and confirm password do not match.'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور جدید و رمز عبور تأیید مطابقت ندارند'
                  : themeProvider.language == 'پشتو'
                  ? 'نوی پټنوم او تایید پټنوم سره سمون نه خوري'
                  : themeProvider.language == 'German'
                      ? 'Neues Passwort und bestätigtes Passwort stimmen nicht überein'
                      : 'New password and confirm password do not match.',
        );
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: _oldPasswordController.text.trim(),
        );
        await user.reauthenticateWithCredential(cred);
        await user.updatePassword(_newPasswordController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( themeProvider.language == 'English'
              ? 'Password changed successfully'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور با موفقیت تغییر کرد'
                  : themeProvider.language == 'پشتو'
                  ? 'پټنوم په بریالیتوب سره بدل شو'
                  : themeProvider.language == 'German'
                      ? 'das Passwort wurde erfolgreich geändert'
                      : 'Password changed successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } else {
        throw FirebaseAuthException(
          code:themeProvider.language == 'English'
              ? 'user-not-found'
              : themeProvider.language == 'فارسی'
                  ? 'کاربر پیدا نشد'
                  : themeProvider.language == 'پشتو'
                  ? 'کارن-نه موندل شوی'
                  : themeProvider.language == 'German'
                      ? 'Benutzer nicht gefunden'
                      : 'user-not-found', 
          message:themeProvider.language == 'English'
              ? 'No user found.'
              : themeProvider.language == 'فارسی'
                  ? 'کاربری پیدا نشد'
                  : themeProvider.language == 'پشتو'
                  ? 'هیڅ کارن ونه موندل شو'
                  : themeProvider.language == 'German'
                      ? 'Kein Benutzer gefunden'
                      : 'No user found.',
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text( themeProvider.language == 'English'
              ? 'Change Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور را تغییر دهید'
                  : themeProvider.language == 'پشتو'
                  ? 'پټ نوم بدل کړی'
                  : themeProvider.language == 'German'
                      ? 'Kennwort ändern'
                      : 'Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  labelText:themeProvider.language == 'English'
              ? 'Old Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور قدیمی'
                  : themeProvider.language == 'پشتو'
                  ? 'زوړ پټ نوم'
                  : themeProvider.language == 'German'
                      ? 'Altes Passwort'
                      : 'Old Password', 
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return themeProvider.language == 'English'
              ? 'Please enter your old password.'
              : themeProvider.language == 'فارسی'
                  ? 'لطفا رمز عبور قدیمی خود را وارد کنید.'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ خپل زوړ پټنوم دننه کړئ.'
                  : themeProvider.language == 'German'
                      ? 'Bitte geben Sie Ihr altes Passwort ein.'
                      : 'Please enter your old password.' ;
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText:themeProvider.language == 'English'
              ? 'New Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور جدید'
                  : themeProvider.language == 'پشتو'
                  ? 'نوئ پټ نوم'
                  : themeProvider.language == 'German'
                      ? 'Neues Kennwort'
                      : 'New Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return themeProvider.language == 'English'
              ? 'Please enter a new password.'
              : themeProvider.language == 'فارسی'
                  ? 'لطفا یک رمز عبور جدید وارد کنید.'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ یو نوی پټنوم دننه کړئ.'
                  : themeProvider.language == 'German'
                      ? 'Bitte geben Sie ein neues Passwort ein.'
                      : 'Please enter a new password.' ;
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: themeProvider.language == 'English'
              ? 'Confirm Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور را تایید کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'پټنوم تایید کړئ'
                  : themeProvider.language == 'German'
                      ? 'Bestätige das Passwort'
                      : 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return themeProvider.language == 'English'
              ? 'Please confirm your new password'
              : themeProvider.language == 'فارسی'
                  ? 'لطفا رمز عبور جدید خود را تایید کنید'
                  : themeProvider.language == 'پشتو'
                  ? 'مهرباني وکړئ خپل نوی پټنوم تایید کړئ'
                  : themeProvider.language == 'German'
                      ? 'Bitte bestätigen Sie Ihr neues Passwort'
                      : 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return themeProvider.language == 'English'
              ? 'Passwords do not match'
              : themeProvider.language == 'فارسی'
                  ? 'رمزهای ورود مطابقت ندارند'
                  : themeProvider.language == 'پشتو'
                  ? 'پاسورډونه سمون نه خوري'
                  : themeProvider.language == 'German'
                      ? 'Passwörter stimmen nicht überein'
                      : 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _isProcessing ? null : _changePassword,
                child: _isProcessing
                    ? CircularProgressIndicator()
                    : Text(themeProvider.language == 'English'
              ? 'Change Password'
              : themeProvider.language == 'فارسی'
                  ? 'رمز عبور را تغییر دهید'
                  : themeProvider.language == 'پشتو'
                  ? ' پټ نوم بدل کړی'
                  : themeProvider.language == 'German'
                      ? 'Kennwort ändern'
                      : 'Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
