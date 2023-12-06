import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/db/db_help.dart';
import 'package:notes_app/utils/home_body.dart';
import 'package:notes_app/pages/add_notes.dart';
import 'package:notes_app/services/provider.dart';
import 'package:notes_app/model/notes_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "Notes App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: MainContent(
        notesList: notesList,
      ),
      floatingActionButton: Consumer<NotesListProvider>(
        builder: (context, value, child){
          return FloatingActionButton(
            // shape: ,
            backgroundColor: Colors.yellow,
            onPressed: () async {
              final data = await Navigator.of(context).push<NotesModel>(
                MaterialPageRoute(
                  builder: (ctx) => const AddNotes(),
                ),
              );
              if (data == null) {
                return;
              }
              // setState(() {
                dbHelper?.insert(data);
              value.refresh();
              // });
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
