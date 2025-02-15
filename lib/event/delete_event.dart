import '../base/base_event.dart';
import '../model/todo_model.dart';

class DeleteTodoEVENT extends BaseEVENT{
Todo todo; //vi list remove Todo
DeleteTodoEVENT(this.todo);
}