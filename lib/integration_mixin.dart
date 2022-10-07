import 'package:colonel/command_base.dart';
import 'package:rxdart/rxdart.dart';

mixin RedoableMixin<T extends CommandBase> {

  List<T> redoStack = [];
  List<T> undoStack = [];

  BehaviorSubject commandRx = BehaviorSubject();

  Future<bool> execute(T command) {
    return command.execute(this)
        .then((success) {
      if (success) {
        commandRx.add(command);
        if (command.isUndoable) {
          undoStack.add(command);
          redoStack.clear();
        }
      }
      return success;
    });
  }

  Future<bool> undo() {
    T command = undoStack.removeLast();
    return command.undo().then((success) {
      if (success) {
        redoStack.add(command);
        commandRx.add(command);
      }
      return success;
    });
  }

  Future<bool> redo() {
    T command = redoStack.removeLast();
    return command.redo().then((success) {
      if (success) {
        undoStack.add(command);
        commandRx.add(command);
      }
      return success;
    });
  }
}