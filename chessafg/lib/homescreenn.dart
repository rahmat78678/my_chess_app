// import 'package:chessafg/admin_screen.dart';
// import 'package:chessafg/news_screen.dart';
// import 'package:flutter/material.dart';

// class HomeScreenn extends StatelessWidget {


//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AdminScreen()),
//                 );
//               },
//               child: Text('Admin Screen'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NewsScreen()),
//                 );
//               },
//               child: Text('News Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:chessafg/news_screen.dart';
import 'package:flutter/material.dart';
import 'admin_screen.dart';  // Ensure this path is correct

class HomeScreenn extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Admin Password'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Enter admin password"),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (_passwordController.text == '1234') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password is not correct')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Go to Admin Screen'),
              onPressed: () {
                _showPasswordDialog(context);
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },
              child: Text('News Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
