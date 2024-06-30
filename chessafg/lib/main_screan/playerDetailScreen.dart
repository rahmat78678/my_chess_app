import 'package:chessafg/main_screan/playerData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:flutter_chess/player_data.dart';

class PlayerDetailScreen extends StatefulWidget {
  final PlayerData player;

  const PlayerDetailScreen({super.key, required this.player});

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Player Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.player.profilePicture),
                radius: 80,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${widget.player.playerName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'World Rank: ${widget.player.worldRank}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Federation: ${widget.player.federation}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'FIDE ID: ${widget.player.fideId}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Birth Year: ${widget.player.birthYear}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Sex: ${widget.player.sex}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'FIDE Title: ${widget.player.fideTitle}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'FIDE Rating: ${widget.player.fideRating}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Black Piece Stats:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ignore: sized_box_for_whitespace
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: widget.player.winsBlack.toDouble(),
                      title: 'Wins: ${widget.player.winsBlack}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: widget.player.losesBlack.toDouble(),
                      title: 'Loses: ${widget.player.losesBlack}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      value: widget.player.drawsBlack.toDouble(),
                      title: 'Draws: ${widget.player.drawsBlack}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'White Piece Stats:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ignore: sized_box_for_whitespace
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: widget.player.winsWhite.toDouble(),
                      title: 'Wins: ${widget.player.winsWhite}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: widget.player.losesWhite.toDouble(),
                      title: 'Loses: ${widget.player.losesWhite}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      value: widget.player.drawsWhite.toDouble(),
                      title: 'Draws: ${widget.player.drawsWhite}',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}