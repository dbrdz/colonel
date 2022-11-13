import 'package:colonel/command_base.dart';
import 'package:rxdart/rxdart.dart';

mixin RedoableMixin<I> {

  List<CommandBase<I>> redoStack = [];
  List<CommandBase<I>> undoStack = [];

  BehaviorSubject commandRx = BehaviorSubject();

  Future<bool> execute(CommandBase<I> command, I input) {
    return command.execute(input)
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
    CommandBase<I> command = undoStack.removeLast();
    return command.undo().then((success) {
      if (success) {
        redoStack.add(command);
        commandRx.add(command);
      }
      return success;
    });
  }

  Future<bool> redo() {
    CommandBase<I> command = redoStack.removeLast();
    return command.redo().then((success) {
      if (success) {
        undoStack.add(command);
        commandRx.add(command);
      }
      return success;
    });
  }
}