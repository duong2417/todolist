import '../base/base_event.dart';

import '../model/todo_model.dart';

class UpdateTodoEVENT extends BaseEVENT{
  Todo todo;int index;
  UpdateTodoEVENT(this.todo,this.index);
}