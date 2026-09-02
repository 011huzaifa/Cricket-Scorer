import 'package:cricket_scorer/logics/innings_controller.dart';
import 'package:cricket_scorer/logics/undo_redo_manager.dart';
import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:cricket_scorer/core/ui/app_widgets.dart';
import 'package:cricket_scorer/screens/score_screen/widgets/innings_over_dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String team1Name;
  final String team2Name;
  String battingTeam;
  final int totalOvers;
  Home({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.battingTeam,
    required this.totalOvers,
  });

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String yetToBatTeam = "";

  //batting second logic
  @override
  void initState() {
    super.initState();
    if (widget.battingTeam != widget.team1Name) {
      yetToBatTeam = widget.team1Name;
    } else {
      yetToBatTeam = widget.team2Name;
    }
  }

  final InningsController innings = InningsController();
  late final UndoRedoManager undoRedoManager = UndoRedoManager(innings);

  //on add runs
  void _onAddRuns(int run) {
    setState(() {
      undoRedoManager.saveState();
      innings.addRun(run);
    });
    // over
    if (innings.isInningsOver(widget.totalOvers)) {
      inngOver();
    }
  }

  // Innings over
  void inngOver() {
    InningsOverDialog.customDialog(
      context,
      titlez: widget.battingTeam,
      content:
          "$yetToBatTeam needs ${innings.score + 1} to win in ${widget.totalOvers * 6} balls",
      callback: () {
        Navigator.pop(context);
        setState(() {
          innings.resetInnings();
        });
      },
    );
    widget.battingTeam = "${innings.score} / ${innings.wickets}";
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team names
                  Text(
                    "${widget.team1Name} vs ${widget.team2Name}",
                    style: TextStyle(fontSize: 23),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Batting 1st & 2nd teams
                      Text(widget.battingTeam, style: TextStyle(fontSize: 14)),
                      Text(yetToBatTeam, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
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
                    "${innings.score} / ${innings.wickets}",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                    textAlign: TextAlign.center,
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
                    "Overs ${innings.balls ~/ 6}.${innings.balls % 6} / ${widget.totalOvers}",
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
                      _onAddRuns(1);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+2",
                    callback: () {
                      _onAddRuns(2);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+3",
                    callback: () {
                      _onAddRuns(3);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+4",
                    callback: () {
                      _onAddRuns(4);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+5",
                    callback: () {
                      _onAddRuns(5);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: true,
                    buttonLabel: "+6",
                    callback: () {
                      _onAddRuns(6);
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: false,
                    buttonLabel: "Wide",
                    callback: () {
                      setState(() {
                        undoRedoManager.saveState();
                        innings.addExtra();
                      });
                    },
                  ),
                  Widgets.scoreButton(
                    isScoreButton: false,
                    buttonLabel: "No Ball",
                    callback: () {
                      setState(() {
                        undoRedoManager.saveState();
                        innings.addExtra();
                      });
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
                    undoRedoManager.saveState();
                    innings.addWicket();
                  });
                  _onAddRuns(0);
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
                    setState(() {
                      undoRedoManager.undo();
                    });
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
                                setState(() {
                                  innings.resetInnings();
                                });
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
                    setState(() {
                      undoRedoManager.redo();
                    });
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
