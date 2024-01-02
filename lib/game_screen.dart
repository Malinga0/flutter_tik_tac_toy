import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tik_tac_toy/home_screen.dart';

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentplayer;
  late String _winner;
  late bool _gameover;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentplayer = "X";
    _winner = "";
    _gameover = false;
  }

  //Restart game
  void _restGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentplayer = "X";
      _winner = "";
      _gameover = false;
    });
  }

  void makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameover) {
      return;
    }
    setState(
      () {
        _board[row][col] = _currentplayer;

        //check for winner
        if (_board[row][0] == _currentplayer &&
            _board[row][1] == _currentplayer &&
            _board[row][2] == _currentplayer) {
          _winner = _currentplayer;
          _gameover = true;
        } else if (_board[0][col] == _currentplayer &&
            _board[1][col] == _currentplayer &&
            _board[2][col] == _currentplayer) {
          _winner = _currentplayer;
          _gameover = true;
        } else if (_board[0][0] == _currentplayer &&
            _board[1][1] == _currentplayer &&
            _board[2][2] == _currentplayer) {
          _winner = _currentplayer;
          _gameover = true;
        } else if (_board[0][2] == _currentplayer &&
            _board[1][1] == _currentplayer &&
            _board[2][0] == _currentplayer) {
          _winner = _currentplayer;
          _gameover = true;
        }

        //switch player
        _currentplayer = _currentplayer == "X" ? "O" : "X";

        if (!_board.any((row) => row.any((cell) => cell == ""))) {
          _gameover = true;
          _winner = "It's a Tie";
        }
        if (_winner != "") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again",
            title: _winner == "X"
                ? widget.player1 + "Won!"
                : _winner == "O"
                    ? widget.player2 + "Won!"
                    : "It's a Tie",
            btnOkOnPress: () {
              _restGame();
            },
          )..show();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 66, 201),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn:",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentplayer == "X"
                            ? widget.player1 + "($_currentplayer)"
                            : widget.player2 + "($_currentplayer)",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _currentplayer == "X"
                              ? Colors.red
                              : Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _restGame,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: Text(
                      "Reset Game",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                    widget.player1 = "";
                    widget.player2 = "";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: Text(
                      "ReStart Game",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
