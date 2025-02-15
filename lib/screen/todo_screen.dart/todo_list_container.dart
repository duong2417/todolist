import 'package:flutter_slidable/flutter_slidable.dart';
import '../../bloc/todo_bloc.dart';
import '../../export/export.dart';
import 'onDELETE.dart';

int i = 0;
// int soCOT = 2;

class TodoListCONTAINER extends StatefulWidget {
  const TodoListCONTAINER({super.key});

  @override
  State<TodoListCONTAINER> createState() => _TodoListCONTAINERState();
}

int dem = 0; //de trong build thi bi reset

class _TodoListCONTAINERState extends State<TodoListCONTAINER> {
  List<TextEditingController> _controllers = [];
  GlobalKey? key;
  TodoBLOC bloc = TodoBLOC();
  ThaoTacVoiBANG bang = ThaoTacVoiBANG();

  @override
  void initState() {
    //chi 1 lan duy nhat
    super.initState();
    bloc.initialDATA(); //luc dau chay thi list=[], den ham buil thi chay nua moi lay dc ptu
    p("bloc.listTODO init", bloc.listTODO); //[] at first of all
    p("_controllers init", _controllers);
  }

  @override
  Widget build(BuildContext context) {
    print("build: ${readONLY}; ${bloc.listTODO}");
    return SlidableAutoCloseBehavior(
      child: StreamBuilder<List<Todo>>(
          //type snapshot.data
          stream: bloc.xuatSTREAM.stream,
          builder: ((context, AsyncSnapshot<List<Todo>> snapshot) {
            _controllers = []; //reset
            print("BUILDER: ${readONLY}; ${bloc.listTODO}");
            if (snapshot.hasData) {
              P(bloc.soCOT);
              return gridVIEW(snapshot, bloc.soCOT);
            }
            return const Center(
                child: Text(
                    "No data")); //đang có mà xóa hêt thì hiện no data chứ ko phải circulorprogressindicator
          })),
    );
  }

  void onEditingCOMPLETE(
      Todo todo, TextEditingController controller, int index) {
  return  TodoBLOC.nhapSTREAM.sink
        .add(UpdateTodoEVENT(Todo(todo.id, controller.text), index));
  }

  Widget itemBUILDER(Todo todo, int index) {
    p("itemBUILDER ${bloc.soCOT}",bloc.listTODO);
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
          motion: const BehindMotion(),
          dismissible: DismissiblePane(
              //chạy qua luôn, container đỏ chiếm full
              // confirmDismiss: () async {
              //   //điều kiện để khung Delete biến mất (khi nào xóa todo xong mới setstate và biến mất)
              //   await onDismiss(context,
              //       snapshot.data![index]);
              //   return true;
              // },

              onDismissed: () =>
                  // setState((){
                  onDELETE(todo, dem, context))
          // ;                // }))
          ,
          children: [
            SlidableAction(
                // 1/2 screen là dừng chứ ko chạy qua lun
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (context) {
                  onDELETE(todo, dem, context);
                  // setState((){});
                }),
          ]),
      child: GestureDetector(
        onDoubleTap: () => setState(() //compulsory
            {
          bloc.closeWhenOPENED();
          TodoBLOC.nhapSTREAM.sink.add(ReadOnlyEVENT(index));
        }),
        child: TextFormField(
          // autofocus:true,
          textInputAction: TextInputAction.send,
          decoration: const InputDecoration(
              isCollapsed: true,//bỏ đường gach chan//textfield nhỏ lại
              // hoverColor: Color.fromARGB(255, 115, 175, 243)//màu của phần trang trí: label, hint...
              ),
          onEditingComplete: () =>
              // setState(() {//nó hiện cái cũ rồi mới hiện cái mới
              onEditingCOMPLETE(todo, _controllers[index], index)
          // })
          ,
          readOnly: readONLY[index],
          controller: _controllers[index],
        ),
      ),
    );
  }

  Widget gridVIEW(snapshot, soCOT) {
    return Expanded(
      //compulsory
      child: GridView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          i = index;
          print("itemBUILDER(co builder chac chan co itembuilder): ${readONLY}; ${bloc.listTODO}");
          Todo todo = snapshot.data![index];
          _controllers.add(TextEditingController());
          p("_controllers", _controllers);
          _controllers[index].text = todo.content;
          p("${todo.id}", index);
          return itemBUILDER(todo, index);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: bloc.soCOT,
            mainAxisExtent:50,
            // childAspectRatio:5,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4.0,
            ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    for (int i = 0; i < bloc.listTODO.length; i++) {
      _controllers[i].dispose();
    }
  }
}
