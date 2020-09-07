import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: SimpleAnimatedList(),
    );
  }
}

class SimpleAnimatedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliceAnimatedList(),
    );
  }
}

class SliceAnimatedList extends StatefulWidget {
  @override
  _SliceAnimatedListState createState() => _SliceAnimatedListState();
}

class _SliceAnimatedListState extends State<SliceAnimatedList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<int> _items = [];
  int counter = 0;

  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutBack,
          reverseCurve: Curves.easeInOutBack),
      child: SizedBox(
        height: 128.0,
        child: Card(
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: textStyle),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            height: double.infinity,
            child: AnimatedList(
              key: listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return slideIt(context, index, animation);
              },
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.greenAccent),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    listKey.currentState.insertItem(0,
                        duration: const Duration(milliseconds: 500));
                    _items = []
                      ..add(counter++)
                      ..addAll(_items);
                  });
                },
                child: Text(
                  "Add item to first",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (_items.length <= 1) return;
                  listKey.currentState.removeItem(
                      0, (_, animation) => slideIt(context, 0, animation),
                      duration: const Duration(milliseconds: 500));
                  setState(() {
                    _items.removeAt(0);
                  });
                },
                child: Text(
                  "Remove first item",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
