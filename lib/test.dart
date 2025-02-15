import 'package:flutter/material.dart';
main()=> runApp(MaterialApp(home:TextFieldListView()));
class TextFieldListView extends StatefulWidget {
  @override
  _TextFieldListViewState createState() => _TextFieldListViewState();
}
                        //  todoTEXTFIELD(),
//                         Visibility(
//                           visible:showTodoLISTILE,
//                           child: ListTile(
//                               leading: Text(todo.id.toString()),
//                               title: Text(
//                                 todo.content,
//                               ),
//                               onTap: () {
// showTodoLISTILE=!showTodoLISTILE;
// showTodoTEXTFIELD=!showTodoTEXTFIELD;
// setState(() {});
//                               }),
//                         ),


  // onTapOUTSIDE() {
  //   bloc.closeWhenOPENED();
  //   print("onTapOutside");
  //   p("onTap trc setState", readONLY);
  //   for (int i = 0; i < readONLY.length; ++i) {
  //     readONLY[i] = true;
  //   }
  // }

                          // onTap: (){

                          //   setState((){p("onTap trc setState",readONLY);
                          //                  for(int i=0;i<readONLY.length;++i){
                          //                   readONLY[i]=true;
                          //                  }
                          //                                   // readONLY.forEach((item)=>item=true);
                          //     });
                          //   p("onTap sau setState",readONLY);

                          //   },


  // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     //chua dat key
          //     return 'Please enter some text'; //error
          //   }
          //   return null; //success
          // },

      //           if (_formKey.currentState !=null){
            //  if (_formKey.currentState!.validate()) {
            //           // print(listTODO);}
            //              }
            //           }


              //vong lap, hạn chế kbao trong đây đẻ tiêt kiệm tài nguyên
                        // if (snapshot.hasData) {
                        //     readONLY=[];
                        //for (int i=0;i<bloc.listTODO.length;i++){
                        // readONLY.add(true);
                        //         }//nó quay lai rồi set toàn bộ = true
class _TextFieldListViewState extends State<TextFieldListView> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    // Khởi tạo danh sách controllers
    for (int i = 0; i < 10; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView of TextFields'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllers[index],
              decoration: InputDecoration(
                labelText: 'TextField ${index + 1}',
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Hủy danh sách controllers
    for (int i = 0; i < 10; i++) {
      _controllers[i].dispose();
    }

    super.dispose();
  }
}