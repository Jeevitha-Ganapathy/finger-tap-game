import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: StartPage()));

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Top Half - Blue
          Container(
            color: Colors.blueAccent,
            height: screenHeight / 2,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                color: Colors.white,
                shape: const CircleBorder(),
                height: 100,
                minWidth: 100,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
                },
                child: const Text("START"),
              ),
            ),
          ),
          // Bottom Half - Red
          Container(
            color: Colors.redAccent,
            height: screenHeight / 2,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                color: Colors.white,
                shape: const CircleBorder(),
                height: 100,
                minWidth: 100,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
                },
                child: const Text("START"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double blueCardHeight = 0;
  double redCardHeight = 0;
  int playerAScore = 0;
  int playerBScore = 0;

  @override
  void initState() {
    super.initState();
    double halfScreen = WidgetsBinding.instance.window.physicalSize.height /
        WidgetsBinding.instance.window.devicePixelRatio /
        2;
    blueCardHeight = halfScreen;
    redCardHeight = halfScreen;
  }

  void updateHeights(String player) {
    setState(() {
      double screenHeight = MediaQuery.of(context).size.height;
      double maxHeight = screenHeight - 60;

      if (player == "A") {
        redCardHeight += 10;
        blueCardHeight -= 10;
        playerAScore += 10;
      } else {
        blueCardHeight += 10;
        redCardHeight -= 10;
        playerBScore += 10;
      }

      if (redCardHeight > maxHeight) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultPage(score: playerAScore, winner: "PLAYER A"),
          ),
        );
      }

      if (blueCardHeight > maxHeight) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultPage(score: playerBScore, winner: "PLAYER B"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => updateHeights("B"),
            child: Container(
              width: double.infinity,
              height: blueCardHeight,
              color: Colors.blueAccent,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player B",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("$playerBScore",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => updateHeights("A"),
            child: Container(
              width: double.infinity,
              height: redCardHeight,
              color: Colors.redAccent,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player A",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("$playerAScore",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final String winner;

  const ResultPage({super.key, required this.score, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$score",
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Text(
              "$winner WON",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StartPage()),
                );
              },
              child: const Text("RESTART GAME"),
            )
          ],
        ),
      ),
    );
  }
}
