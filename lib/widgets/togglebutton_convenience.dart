import 'package:flutter/material.dart';

class TBMultipleConvenience extends StatefulWidget {
  @override
  _ToggleButtonMultipleState createState() => _ToggleButtonMultipleState();
}

class _ToggleButtonMultipleState extends State<TBMultipleConvenience> {
  List<bool> isSelected = [true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) => ToggleButtons(
      isSelected: isSelected,
      /*
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: Colors.lightBlue.shade900,
      borderWidth: 3,
      borderColor: Colors.lightBlue.shade900,
      selectedBorderColor: Colors.lightBlue,
      */
      borderRadius: BorderRadius.circular(10),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('전체', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('CU', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('GS25', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('세븐일레븐', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('이마트24', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('미니스톱', style: TextStyle(fontSize: 13)),
        ),
      ],
      onPressed: (int newIndex) {
        final isOneSelected =
            isSelected.where((element) => element).length == 1;
        if (isOneSelected && isSelected[newIndex]) return;

        setState(() {
          /* 0번째가 true인 상태에서 1~끝까지 선택되면 0번째는 false */
          if ((isSelected[0] == true) && isSelected[newIndex] == false) {
            isSelected[0] = false;
          }
          /* 0번째가 false인 상태에서 0번째가 선택되면 0번째는 true, 1~끝은 모두 false*/
          else if ((isSelected[0] == false) && newIndex == 0) {
            for (int index = 1; index < isSelected.length; index++) {
              isSelected[index] = false;
            }
          } else {}

          /*같은 것 판별해서 역으로 만들기*/
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = !isSelected[index];
            }
          }
        });
      });
}
