// class ChessGame {
//   final String id;
//   final String player1;
//   final String player2;
//   final List<String> moves;

//   ChessGame({
//     required this.id,
//     required this.player1,
//     required this.player2,
//     required this.moves,
//   });

//   factory ChessGame.fromMap(Map<String, dynamic> data, String id) {
//     return ChessGame(
//       id: id,
//       player1: data['player1'],
//       player2: data['player2'],
//       moves: List<String>.from(data['moves']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'player1': player1,
//       'player2': player2,
//       'moves': moves,
//     };
//   }
// }
