import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'ToDoItem.dart';
import 'dart:async';


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
  String _selectedDate;
  var formatter = new DateFormat('yyyy-MM-dd');
  TextEditingController _labelCont;
  TextEditingController _descCont;
  
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      if(widget.toDoItem.lable != ''){
        _labelCont = new TextEditingController(text:widget.toDoItem.lable);
        _descCont = new TextEditingController(text:widget.toDoItem.description);
        _selectedDate = widget.toDoItem.date;
      }
      else{
         var now = new DateTime.now();
        _selectedDate = formatter.format(now);
        _labelCont = new TextEditingController();
        _descCont = new TextEditingController();
      }
    }

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
            ),
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
          new ListTile(
            title : new Text('Date :')
          ),
          new ListTile(
            title: new Row(
              children: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.calendar_today),
                    tooltip: 'Calender',
                    onPressed: _openDatePicker
                  ),
                  new Text(_selectedDate),
              ],
            )
          ),
          new RaisedButton(
            child: new Text('Save'),
            onPressed: (){
              if(_label != null){
                widget.toDoItem.lable = _label;
                widget.toDoItem.description = _description;
                widget.toDoItem.date = _selectedDate;
                Navigator.of(context).pop(widget.toDoItem);
              }
              else{
                showDialog(
                  context: context,
                  child: new AlertDialog(
                    title : new Text("Please enter ToDo Lable"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ), 
                    ],
                  )
                );
              }
            }),
          ]
      ),
    );
  }

  _openDatePicker(){
      Future<DateTime> selectedDate = showDatePicker(context : context,
                                              initialDate: new DateTime.now(),
                                              firstDate: new DateTime(1990),
                                              lastDate: new DateTime(2300));
      selectedDate.then((value) => _selectedDate = formatter.format(value));
  }

}