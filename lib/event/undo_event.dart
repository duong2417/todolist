import '../base/base_event.dart';
import '../model/todo_model.dart';

class UndoTodoEVENT extends BaseEVENT{
  Todo todo;
UndoTodoEVENT(this.todo);
}