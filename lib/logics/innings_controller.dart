class InningsController {
  int score = 0;
  int wickets = 0;
  int balls = 0;
  String completedOvers = "0.0";

  //add runs
  void addRun(int run) {
    score += run;
    balls++;
    // completedOvers = "${balls ~/ 6}.${balls % 6}";
  }

  // add wickets
  void addWicket() {
    if (wickets < 10) wickets++;
  }

  // add extras
  void addExtra() {
    score++;
  }

  // innings over
  bool isInningsOver(int overs) {
    return balls == overs * 6 || wickets == 10;
  }

  //reset innings
  void resetInnings() {
    score = 0;
    wickets = 0;
    balls = 0;
    completedOvers = "0.0";
  }
}
