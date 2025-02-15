import '../../bloc/todo_bloc.dart';
import '../../event/delete_event.dart';
import '../../event/undo_event.dart';
import '../../export/export.dart';

void onDELETE(Todo todo,int dem,BuildContext context) {
    TodoBLOC.nhapSTREAM.sink.add(DeleteTodoEVENT(todo));
    ++dem;
    var snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text("$todo is deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            return TodoBLOC.nhapSTREAM.sink.add(UndoTodoEVENT(todo));
          }),
    );

    if (dem <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }