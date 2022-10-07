class CommandUndoException implements Exception {
  CommandUndoException(): super();

  final dynamic message = 'Cannot undo a command that hasn\'t been executed';
}

class CommandRedoException implements Exception {
  CommandRedoException(): super();

  final dynamic message = 'Cannot redo a command that hasn\'t been executed';
}