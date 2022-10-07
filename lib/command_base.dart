import 'package:rxdart/rxdart.dart';

typedef UndoRedoFunction = Future<bool> Function();
typedef CommandCallback = Function(CommandBase);

abstract class CommandBase<T> {
  CommandBase({ timestamp });
  static BehaviorSubject listener = BehaviorSubject();
  bool notifyListenersOnExecution = true;

  Future<bool> execute(T element);
  Future<bool> undo();
  Future<bool> redo();
  bool get isUndoable;
}