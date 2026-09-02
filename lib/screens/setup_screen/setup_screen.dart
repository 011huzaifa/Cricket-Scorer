import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:cricket_scorer/screens/score_screen/score_screen.dart';
import 'package:cricket_scorer/core/ui/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreen();
}

class _SetupScreen extends State<SetupScreen> {
  TextEditingController team1 = TextEditingController();
  TextEditingController team2 = TextEditingController();
  TextEditingController oversController = TextEditingController();
  String? _selectedTeam;
  String battingTeam = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Match"),
        centerTitle: true,
        backgroundColor: Appcolors.primaryColor,
        foregroundColor: Appcolors.backgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Widgets.customButton(
              buttonLabel: "New Match",
              outlined: false,
              callback: () => {
                showModalBottomSheet(
                  sheetAnimationStyle: AnimationStyle(
                    duration: Duration(milliseconds: 650),
                    reverseDuration: Duration(milliseconds: 750),
                  ),
                  isScrollControlled: true,
                  showDragHandle: true,
                  backgroundColor: Colors.indigo[50],
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(
                      builder: (context, setDialogState) {
                        return FractionallySizedBox(
                          heightFactor: 0.90,
                          child: Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 12,
                                children: [
                                  Widgets.customTextFeild(
                                    controller: team1,
                                    onChanged: (value) => setDialogState(() {}),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter team name";
                                      }
                                      return null;
                                    },
                                    hintText: "Team 1",
                                    labelText: "Team Name",
                                  ),
                                  Widgets.customTextFeild(
                                    controller: team2,
                                    onChanged: (value) => setDialogState(() {}),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter team name";
                                      }
                                      return null;
                                    },
                                    hintText: "Team 2",
                                    labelText: "Team Name",
                                  ),
                                  Widgets.customTextFeild(
                                    inputType: TextInputType.number,
                                    inputFormatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: oversController,
                                    onChanged: (value) => setDialogState(() {}),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Overs";
                                      }
                                      return null;
                                    },
                                    hintText: "Overs?",
                                    labelText: "Overs",
                                  ),
                                  Text("Who will bat first?"),
                                  RadioGroup<String>(
                                    groupValue: _selectedTeam,
                                    onChanged: (String? value) {
                                      setDialogState(() {
                                        _selectedTeam = value;
                                        battingTeam = value!;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        RadioListTile<String>(
                                          value: team1.text.isEmpty
                                              ? "Team 1"
                                              : team1.text,
                                          title: Text(
                                            team1.text.isEmpty
                                                ? "Team 1"
                                                : team1.text,
                                          ),
                                        ),
                                        RadioListTile<String>(
                                          value: team2.text.isEmpty
                                              ? "Team 2"
                                              : team2.text,
                                          title: Text(
                                            team2.text.isEmpty
                                                ? "Team 2"
                                                : team2.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Widgets.customButton(
                                    buttonLabel: "Start",
                                    fullWidth: true,
                                    callback: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Home(
                                                team1Name: team1.text,
                                                team2Name: team2.text,
                                                battingTeam: battingTeam,
                                                totalOvers: int.parse(
                                                  oversController.text,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              },
            ),
            Widgets.customButton(
              buttonLabel: "Previous Match",
              outlined: true,
              callback: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
