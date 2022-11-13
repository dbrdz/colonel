import 'package:colonel/command_base.dart';

class CommandWrapper<OuterInput, InnerInput> extends CommandBase<OuterInput> {
  CommandWrapper({ required this.command, required this.input });

  final CommandBase<InnerInput> command;
  final InnerInput input;

  @override
  Future<bool> execute(OuterInput element) {
    return command.execute(input);
  }

  @override
  bool get isUndoable => command.isUndoable;

  @override
  Future<bool> redo() {
    return command.redo();
  }

  @override
  Future<bool> undo() {
    return command.undo();
  }

}