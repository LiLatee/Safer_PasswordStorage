import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: TodoListView(title: 'Flutter reorderable listview'),
    );
  }
}

class TodoListView extends StatefulWidget {
  TodoListView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<TodoListView> {
  List<TaskModel> taskList = [
    TaskModel(id: '1', title: 'Test app 1', status: 'Completed', name: 'John'),
    TaskModel(
        id: '2', title: 'Test app 2', status: 'In progress', name: 'Jenny'),
    TaskModel(id: '3', title: 'Test app 3', status: 'Not started', name: 'Jane')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorderable List'),
      ),
      body: buildBody(),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final TaskModel item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }

  Widget ownerNameWidget(TaskModel todo) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Owner',
                style: TextStyle(
                  fontSize: 17.07,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                '${todo.name}',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusWidget(TaskModel todo) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                'status',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                '${todo.status}',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toDo(TaskModel todo) {
    return Container(
        key: Key(todo.id),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
            //color: const Color(0xFF66BB6A),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 5.0,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(
                10.0,
              ),
              child: Text(
                todo.title,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ownerNameWidget(todo),
                  statusWidget(todo),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildBody() {
    return ReorderableListView(
      children: taskList.map((todo) {
        return toDo(todo);
      }).toList(),
      onReorder: _onReorder,
    );
  }
}

class TaskModel {
  String id;
  String title;
  String status;
  String name;

  TaskModel(
      {required this.id,
      required this.title,
      required this.status,
      required this.name});
}
