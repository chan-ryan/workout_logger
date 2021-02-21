import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {},
              ),
              TextButton(
                child: Text("Month Year",
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {},
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          child: Icon(Icons.add_rounded),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  //list view (default)
                  icon: Icon(Icons.table_rows_rounded),
                  color: index == 0 ? Colors.white : Colors.grey[400],
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                ),
                placeholder,
                IconButton(
                  //calendar view
                  icon: Icon(Icons.calendar_today_rounded),
                  color: index == 1 ? Colors.white : Colors.grey[400],
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                )
              ],
            )));
  }
}

Widget placeholder = Opacity(
  opacity: 0,
  child: IconButton(
    icon: Icon(Icons.place),
    onPressed: () {},
  ),
);
