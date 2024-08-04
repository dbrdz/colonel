import 'package:rxdart/rxdart.dart';

import 'command_exceptions.dart';

typedef UndoRedoFunction = Future<bool> Function();
typedef CommandCallback = Function(CommandBase);

enum ExecutionState { notExecuted, executed, undone, redone }

abstract class CommandBase<T> {
  CommandBase({ timestamp });

  bool notifyListenersOnExecution = true;
  static BehaviorSubject listener = BehaviorSubject();
  ExecutionState executionState = ExecutionState.notExecuted;

  Future<bool> execute();
  Future<bool> undo();
  Future<bool> redo();
  bool get isUndoable;

  void assertCanExecute() {
    if (executionState == ExecutionState.executed || executionState == ExecutionState.redone) {
      throw CommandExecutionException();
    }
  }

  void assertCanRedo() {
    if (executionState != ExecutionState.undone) {
      throw CommandRedoException();
    }
  }

  void assertCanUndo() {
    if (isUndoable == false) {
      throw CommandUndoException();
    }
    if (executionState != ExecutionState.executed || executionState != ExecutionState.redone) {
      throw CommandUndoException();
    }
  }
}