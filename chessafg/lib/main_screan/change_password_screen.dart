// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _oldPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> _changePassword() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'User not found';
//       });
//       return;
//     }

//     try {
//       // Reauthenticate user
//       final credential = EmailAuthProvider.credential(
//         email: user.email!,
//         password: _oldPasswordController.text,
//       );

//       await user.reauthenticateWithCredential(credential);

//       // Change password
//       await user.updatePassword(_newPasswordController.text);

//       setState(() {
//         _isLoading = false;
//       });

//       // Navigate back
//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password changed successfully')),
//       );
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _oldPasswordController,
//                 decoration: InputDecoration(labelText: 'Old Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your old password';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _newPasswordController,
//                 decoration: InputDecoration(labelText: 'New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your new password';
//                   } else if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState?.validate() == true) {
//                           _changePassword();
//                         }
//                       },
//                       child: Text('Change Password'),
//                     ),
//               if (_errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: Text(
//                     _errorMessage!,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





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
    setState(() {
      _isProcessing = true;
    });

    try {
      // Ensure new password and confirm password match
      if (_newPasswordController.text != _confirmPasswordController.text) {
        throw FirebaseAuthException(
          code: 'passwords-not-matching',
          message: 'New password and confirm password do not match.',
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
            content: Text('Password changed successfully.'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found.',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
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
                  labelText: 'Old Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password.';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match.';
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
                    : Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
