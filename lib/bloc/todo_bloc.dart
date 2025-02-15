import '../export/export.dart';

List<bool> readONLY = []; //toan cuc de ko bi reset
int id=0;

class TodoBLOC extends BaseBLOC {
  int soCOT=1;
  static StreamController<BaseEVENT> nhapSTREAM = StreamController<
      BaseEVENT>.broadcast(); //phai static no moi hien listview//phai broadcast moi het has been listened
  final StreamController<List<Todo>> _xuatSTREAM =
      StreamController<List<Todo>>();
  List<Todo> listTODO =
      []; //để lưu data kiểu List<Todo> not Future<List<Todo>> của selectAll -> bloc mới in data ra đc
  StreamController<List<Todo>> get xuatSTREAM => _xuatSTREAM;

  initialDATA() async {
    listTODO = await ThaoTacVoiBANG().selectAll();
    _xuatSTREAM.sink.add(listTODO); //compulsory
    readONLY.clear();
    for (int i = 0; i < listTODO.length; i++) {
      readONLY.add(true); //compulsory
    }
  }

  final ThaoTacVoiBANG _bang = ThaoTacVoiBANG();
  void undoTODO(Todo todo)async{
  await _bang.insertTodo(todo);
  listTODO.insert(i,todo);
    _xuatSTREAM.sink.add(listTODO);
     closeWhenOPENED();
  }
  void addTODO(Todo todo) async {
    await _bang.insertTodo(todo);
    listTODO.add(todo);//add 2 lan: init voi anddEVENT
    _xuatSTREAM.sink.add(listTODO);
    closeWhenOPENED(); //add todo rồi, thì readONLY mới ko bị lỗi range do index cuối > listTODO.length -> vựơt quá 1 ptu (readONLY.length=listTODO.length)
  }

  void deleteTODO(DeleteTodoEVENT event) async {
    await _bang.deleteTodo(event.todo);
    listTODO.remove(event.todo);
    _xuatSTREAM.sink.add(listTODO);
    
  }
  void updateTODO(UpdateTodoEVENT event)async{
 await ThaoTacVoiBANG().updateTodo(event.todo);
         p("event.todo.id",event.todo.id);
        
         p("update listTODO",listTODO);
          listTODO[event.index]=event.todo;
          // listTODO[event.todo.id]=event.todo;
         p("replace listTODO",listTODO);

          xuatSTREAM.sink.add(listTODO);
         p("xuatSTREAM listTODO",listTODO);
  }

  TodoBLOC() {
    nhapSTREAM.stream.listen((BaseEVENT event) {
      if (event is AddTodoEVENT) {
        // int id = Random().nextInt(1000);
        id++;
        Todo todo = Todo(id, event.content);
        addTODO(todo);
        // closeWhenOPENED();//đồng bộ (await ko có td): chạy đồng thời nào có KQ trước thì thực hiện trc nên ko thể đặt hàm này ở đây mà chuyển lên hàm bất đồng bộ addTODO
      } else if (event is DeleteTodoEVENT) {
        deleteTODO(event);
      } else if (event is ReadOnlyEVENT) {
            P(listTODO.length);
        readONLY[event.index!] = false;//tắt chỉ đọc
      }
      else if (event is UpdateTodoEVENT){
        updateTODO(event);

      }
      else if (event is UndoTodoEVENT){
undoTODO(event.todo);
      }
      else if(event is SliderEVENT){
        soCOT = event.value.toInt();
    _xuatSTREAM.sink.add(listTODO);//compulsory, có này nó mới builder lại gridview

      }
      // xuatSTREAM.sink.add(listTODO);//disabled
    });
  }
  void closeWhenOPENED() {//doubleTap todo khac thi todo nay reaOnly
    {
      readONLY = [];
      for (int i = 0; i < listTODO.length; i++) {
        readONLY.add(true);
      } //size readONLY va size listTODO dong thoi cùng bằng nhau
    }
  }

  void dispose() {
    nhapSTREAM.close();//ko cho stream lang nghe nua
    _xuatSTREAM.close();
    ThaoTacVoiBANG().close();
  }
}
