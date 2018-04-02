import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'todoForm.dart';
import 'ToDoItem.dart';
import 'dart:async';

void main() {
      runApp(
        new MaterialApp(
          home: new ListWidget(),
        )
      );
}

class ListWidget extends StatefulWidget{
                 
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListWidget>{
  
  List<ToDoItem> toDoList = new List();
  DatabaseReference reference;
  
  _ListState(){
    reference = FirebaseDatabase.instance.reference().child('TodoList');     
    reference.onChildAdded.listen(_onDataAdded);
  }

  _onDataAdded(Event e){
    setState(() {
      toDoList.add(new ToDoItem.fromSnapShot(e.snapshot));
    });
  }  

  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }

   @override
   Widget build(BuildContext context){
     return new Scaffold(
       appBar : new AppBar(
         title: new Text("ToDo List"),
       ),
       body : new ListView(
        padding: const EdgeInsets.all(10.0),
        children : toDoList.map((ToDoItem todoitem){
          return new ListTile(
            title : new Text(todoitem.lable));
        }).toList(),
       ),
        floatingActionButton: new FloatingActionButton(
         child: new Text('+'),
         onPressed: _addTodo
       ) ,
     );
   }

   Future _addTodo() async{
    //print('Add ToDo');
    ToDoItem newlyAddedItem = await Navigator.of(context).push(
          new MaterialPageRoute<ToDoItem>(
            builder: (BuildContext context){
              return new TodoAddWidget.add(new ToDoItem('', '', ''));
            })
      );
    if(newlyAddedItem != null){
      reference.push().set(newlyAddedItem.toJson());
    }
  }
}