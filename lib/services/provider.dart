import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/db/db_help.dart';
import 'package:notes_app/model/notes_model.dart';

class NotesListProvider extends ChangeNotifier {
  DBHelper db= DBHelper();

  late Future<List<NotesModel>> _list;
  Future<List<NotesModel>> get notesListGetter => _list;

  Future<List<NotesModel>> getData() async{
    try{
      _list= db.getNotesList();
    }
    catch(e){
      debugPrint("Provider Error: ${e.toString()}");
    }
    return _list;
  }

  void refresh(){
    notifyListeners();
  }

  Future<int> updateListWithProvider(NotesModel note) async{
    late Future<int> val;
    try{
      val= db.update(note);
    }
    catch(e){
      debugPrint("Provider Error: ${e.toString()}");
    }
    notifyListeners();
    return val;
  }
  Future<int> deleteListWithProvider(NotesModel note) async{
    late Future<int> val;
    try{
      val= db.delete(note.id);
    }
    catch(e){
      debugPrint("Provider Error: ${e.toString()}");
    }
    notifyListeners();
    return val;
  }
}
