// import 'package:chessafg/chess_game.dart';
// import 'package:chessafg/game-detail-screen.dart';
// import 'package:chessafg/main.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PreviousGamesScreen extends StatelessWidget {
//   final FirestoreService firestoreService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       appBar: AppBar(title: Text('Previous Games')),
//       body: StreamBuilder<List<ChessGame>>(
//         stream: firestoreService.getUserGames(user!.uid),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final games = snapshot.data!;
//           return ListView.builder(
//             itemCount: games.length,
//             itemBuilder: (context, index) {
//               final game = games[index];
//               return ListTile(
//                 title: Text('${game.player1} vs ${game.player2}'),
//                 subtitle: Text('Moves: ${game.moves.length}'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => GameDetailScreen(game: game),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
