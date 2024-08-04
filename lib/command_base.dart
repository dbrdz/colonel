import 'package:rxdart/rxdart.dart';

typedef UndoRedoFunction = Future<bool> Function();
typedef CommandCallback = Function(CommandBase);

abstract class CommandBase<T> {
  CommandBase({ timestamp });
  bool notifyListenersOnExecution = true;
  static BehaviorSubject listener = BehaviorSubject();

  Future<bool> execute();
  Future<bool> undo();
  Future<bool> redo();
  bool get isUndoable;
}