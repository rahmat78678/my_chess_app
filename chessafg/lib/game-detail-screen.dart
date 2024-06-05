// import 'package:chessafg/chess_game.dart';
// import 'package:flutter/material.dart';

// class GameDetailScreen extends StatefulWidget {
//   final ChessGame game;

//   GameDetailScreen({required this.game});

//   @override
//   _GameDetailScreenState createState() => _GameDetailScreenState();
// }

// class _GameDetailScreenState extends State<GameDetailScreen> {
//   int _currentMoveIndex = 0;

//   void _nextMove() {
//     setState(() {
//       if (_currentMoveIndex < widget.game.moves.length - 1) {
//         _currentMoveIndex++;
//       }
//     });
//   }

//   void _previousMove() {
//     setState(() {
//       if (_currentMoveIndex > 0) {
//         _currentMoveIndex--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Game Details')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: Text('Move: ${widget.game.moves[_currentMoveIndex]}'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: _previousMove,
//                 child: Text('Previous Move'),
//               ),
//               ElevatedButton(
//                 onPressed: _nextMove,
//                 child: Text('Next Move'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
