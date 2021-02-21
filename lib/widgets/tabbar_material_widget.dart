import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarMaterialWidget({this.index, this.onChangedTab, Key key})
      : super(key: key);

  @override
  _TabBarMaterialWidgetState createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  Widget placeholder = Opacity(
    opacity: 0,
    child: IconButton(
      icon: Icon(Icons.no_cell),
      onPressed: () {},
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabItem(index: 0, icon: Icon(Icons.table_rows_rounded)),
            placeholder,
            buildTabItem(index: 1, icon: Icon(Icons.calendar_today_rounded))
          ],
        ));
  }
}

Widget buildTabItem({int index, Icon icon}) {
  return IconTheme(
      data: IconThemeData(), child: IconButton(icon: icon, onPressed: () {}));
}
