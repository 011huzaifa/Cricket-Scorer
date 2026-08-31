import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:cricket_scorer/core/screens/Score_Screen.dart';
import 'package:cricket_scorer/core/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchSelectionScreen extends StatefulWidget {
  const MatchSelectionScreen({super.key});

  @override
  State<MatchSelectionScreen> createState() => _MatchSelectionScreen();
}

class _MatchSelectionScreen extends State<MatchSelectionScreen> {
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
                showDialog(
                  context: context,
                  fullscreenDialog: true,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setDialogState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: SizedBox(
                            // height: 435,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Text(battingTeam),
                                  TextFormField(
                                    controller: team1,
                                    onChanged: (value) => setDialogState(() {}),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter team name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "1st Team Name",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Appcolors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: team2,
                                    onChanged: (value) => setDialogState(() {}),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter team name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "2nd Team Name",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Appcolors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter> [
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
                                    decoration: InputDecoration(
                                      hintText: "Overs?",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Appcolors.primaryColor,
                                        ),
                                      ),
                                    ),
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
                                    buttonLabel: "Submit",
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
                                                totalOvers: int.parse(oversController.text),
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
