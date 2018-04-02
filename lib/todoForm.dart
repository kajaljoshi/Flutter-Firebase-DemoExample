import 'package:flutter/material.dart';
import 'ToDoItem.dart';


class TodoAddWidget extends StatefulWidget{
  final ToDoItem toDoItem;

  TodoAddWidget.add(this.toDoItem);

  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }

  @override
  _ListAddState createState() => new _ListAddState();
}

class _ListAddState extends State<TodoAddWidget>{
  
  String _label ;
  String _description ;
  final TextEditingController _labelCont = new TextEditingController();
  final TextEditingController _descCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar : new AppBar(
         title: new Text("Add ToDo Item"),
       ),
       body : new Column(
        children: <Widget>[
          new ListTile(
            title: new Text('ToDo Lable :'),
          ),
          new ListTile(
            title : new TextField(
              controller: _labelCont,
              decoration: new InputDecoration(
                hintText: 'Add Label',
              ),
              onChanged: (value) => _label = value,
            )
          ),
          new ListTile(
            title: new Text('ToDo Description :'),
          ),
          new ListTile(
            title : new TextField(
              controller: _descCont,
              decoration: new InputDecoration(
                hintText: 'Add Description',
              ),
              onChanged: (value) => _description = value,
            )
          ),
          new RaisedButton(
            child: new Text('Save'),
            onPressed: (){
              widget.toDoItem.lable = _label;
              widget.toDoItem.description = _description;
              Navigator.of(context).pop(widget.toDoItem);
            }),
          ]
      ),
    );
  }

}