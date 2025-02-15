import 'package:flutter/material.dart';
import '../../bloc/todo_bloc.dart';
import '../../event/add_event.dart';
import '../../event/slider_event.dart';
import 'todo_list_container.dart';

import '../../debug.dart';

class HEADER extends StatefulWidget {
  const HEADER({super.key});

  @override
  State<HEADER> createState() => _HEADERState();
}

class _HEADERState extends State<HEADER> {
  // final _formKey = GlobalKey<FormState>();
// int _currentSliderVALUE = soCOT;

  TodoBLOC bloc = TodoBLOC();
  TextEditingController textCONTROLLER = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          TextFormField(
            maxLines: 1,
            // key: _formKey,
            controller: textCONTROLLER,
          ),
          TextButton(
            onPressed: () {
              p("bloc.listTODO", bloc.listTODO); //[]
              dem = 0;
              TodoBLOC.nhapSTREAM.sink.add(AddTodoEVENT(
                textCONTROLLER.text,
              )); //BAN THAN BLOC DA CO SETSTATE
              textCONTROLLER.text = '';
            },
            child: const Text("Send"),
          ),
        ]),
        Slider(
          //         onChangeStart: (double startValue) {
          //   print('Started change at $startValue');
          //    return  setState(() {TodoBLOC.nhapSTREAM.sink.add(SliderEVENT(startValue));
          //                         });
          // },
          //      onChangeEnd: (double startValue) {
          //   print('End change at $startValue');
          //    return  setState(() {TodoBLOC.nhapSTREAM.sink.add(SliderEVENT(startValue));
          //                        });
          // },//thông báo khi người dùng bắt đầu chọn một giá trị mới bằng cách bắt đầu kéo hoặc nhấn
          value: bloc.soCOT.toDouble(), //currentSliderValue
          min:1,
          max: 6,
          label: bloc.soCOT.round().toString(), //ROUND=LAM TRON
          onChanged: (double value) {
            return setState((() //compulsory, ko có nó thì chỉ update gridview chứ ko update thanh slider 
            => TodoBLOC.nhapSTREAM.sink.add(SliderEVENT(value))));
          },
          // divisions: 6, //số phân đoạn (số chấm tròn nhỏ trên thanh slider)
        )
      ],
    );
  }
}
