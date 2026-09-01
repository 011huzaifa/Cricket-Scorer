import 'package:cricket_scorer/logics/innings_controller.dart';
import 'package:cricket_scorer/model/GameState.dart';

class UndoRedoManager {
  final InningsController innings;

  UndoRedoManager(this.innings);

  List<GameState> undoStack = [];
  List<GameState> redoStack = [];

  //saving the current state
  void saveState() {
    undoStack.add(
      GameState(
        score: innings.score,
        wickets: innings.wickets,
        balls: innings.balls,
      ),
    );

    redoStack.clear();
  }

  //undo function
  void undo() {
    if (undoStack.isEmpty) return;

    redoStack.add(
      GameState(
        score: innings.score,
        wickets: innings.wickets,
        balls: innings.balls,
      ),
    );

    GameState previousState = undoStack.removeLast();

    innings.score = previousState.score;
    innings.wickets = previousState.wickets;
    innings.balls = previousState.balls;
  }

  //redo function
  void redo() {
    if (redoStack.isEmpty) return;

    undoStack.add(
      GameState(
        score: innings.score,
        wickets: innings.wickets,
        balls: innings.balls,
      ),
    );

    GameState nextState = redoStack.removeLast();
    innings.score = nextState.score;
    innings.wickets = nextState.wickets;
    innings.balls = nextState.balls;
  }
}
