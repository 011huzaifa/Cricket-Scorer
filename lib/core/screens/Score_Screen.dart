import 'package:cricket_scorer/GameState.dart';
import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:cricket_scorer/core/ui/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String team1Name;
  final String team2Name;
  const Home({super.key, required this.team1Name, required this.team2Name});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int score = 0;
  int wickets = 0;
  int balls = 0;

  List<GameState> undoStack = [];
  List<GameState> redoStack = [];

  //save current state
  void saveState() {
    undoStack.add(GameState(score: score, wickets: wickets, balls: balls));

    redoStack.clear();
  }

  //undo
  void undo() {
    if (undoStack.isEmpty) return;

    setState(() {
      redoStack.add(GameState(score: score, wickets: wickets, balls: balls));

      GameState previousState = undoStack.removeLast();

      score = previousState.score;
      wickets = previousState.wickets;
      balls = previousState.balls;
    });
  }

  //redo
  void redo() {
    if (redoStack.isEmpty) return;

    setState(() {
      undoStack.add(GameState(score: score, wickets: wickets, balls: balls));

      GameState nextState = redoStack.removeLast();

      score = nextState.score;
      wickets = nextState.wickets;
      balls = nextState.balls;
    });
  }

  //reset innings
  void resetInnings() {
    setState(() {
      score = 0;
      wickets = 0;
      balls = 0;
      undoStack.clear();
      redoStack.clear();
    });
  }

  //add runs
  void addRuns(int run) {
    setState(() {
      saveState();
      score += run;
      balls++;
    });
  }

  void extras() {
    setState(() {
      saveState();
      score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score Manage", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Appcolors.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // margin: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   border: BoxBorder.all(width: 2, color: Appcolors.primaryColor),
        //   borderRadius: BorderRadius.circular(13),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Team names
            Text(
              "${widget.team1Name} vs ${widget.team2Name}",
              style: TextStyle(fontSize: 22),
            ),
            //Score, Wickets and balls
            Container(
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                // border: BoxBorder.all(width: 2, color: Colors.red),
                color: Appcolors.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Score and Wickets
                  Text(
                    "$score / $wickets",
                    style: TextStyle(fontSize: 33, color: Colors.white),
                  ),
                  Divider(
                    height: 8,
                    thickness: 1,
                    color: Colors.white54,
                    indent: 20,
                    endIndent: 20,
                  ),
                  // balls
                  Text(
                    "Overs ${balls ~/ 6}.${balls % 6}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 135,
              margin: EdgeInsets.only(top: 0, left: 16, bottom: 16, right: 16),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.8,
                ),
                children: [
                  Widgets.scoreButton(
                    buttonLabel: "+1",
                    isScoreButton: true,
                    callback: () {
                      addRuns(1);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+2",
                    callback: () {
                      addRuns(2);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+3",
                    callback: () {
                      addRuns(3);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+4",
                    callback: () {
                      addRuns(4);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+5",
                    callback: () {
                      addRuns(5);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+6",
                    callback: () {
                      addRuns(6);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: false,
                    buttonLabel: "Wide",
                    callback: () {
                      extras();
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: false,
                    buttonLabel: "No Ball",
                    callback: () {
                      extras();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                // border: BoxBorder.all(width: 2, color: Colors.red),
                color: Appcolors.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (wickets < 10) {
                      saveState();
                      addRuns(0);
                      wickets++;
                    }
                    if (wickets == 10) {
                      showDialog(
                        barrierDismissible: false,
                        context: (context),
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text("Innings Over!"),
                            content: Text("Want to start again?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  resetInnings();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Appcolors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                child: Text(
                  "Wicket",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            //Undo, Redo and Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                IconButton(
                  onPressed: () {
                    undo();
                  },
                  icon: Icon(Icons.undo),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: (context),
                      fullscreenDialog: true,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Restart"),
                          content: const Text("Want to restart"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: TextStyle(color: Appcolors.primaryColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                resetInnings();
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Appcolors.primaryColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.sync),
                ),
                IconButton(
                  onPressed: () {
                    redo();
                  },
                  icon: Icon(Icons.redo),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
