import 'package:firebase_database/firebase_database.dart';


class ToDoItem{
  String lable;
  String date;
  String description;
  ToDoItem(this.lable,this.date,this.description);

  ToDoItem.fromSnapShot(DataSnapshot snapShot)
        :lable = snapShot.value["Label"],
        date = snapShot.value["Date"],
        description = snapShot.value["Description"];

  toJson() {
    return {
      "Label": lable,
      "Date": date,
      "Description": description
    };
  }

}