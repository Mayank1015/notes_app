import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/utils/custom_app_bar.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  int totalBodyCharLength = 0;
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = "";
  String _enteredBody = "";

  void _back() {
    Navigator.of(context).pop();
  }

  void _onSave() {
    _formKey.currentState!.save();
    final id= uuid.v4();
    if (_enteredBody.isEmpty && _enteredTitle.isEmpty) {
      Navigator.of(context).pop();
    } else if (_enteredTitle.isEmpty && _enteredBody.isNotEmpty) {
      NotesModel data = NotesModel(
        id: id,
        title: "Untitled",
        desc: _enteredBody.trim(),
      );
      Navigator.of(context).pop(data);
    } else if (_enteredTitle.isNotEmpty && _enteredBody.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Add body of the note..."),
        ),
      );
      return;
    } else {
      Navigator.of(context).pop(NotesModel(
        id: id,
        title: _enteredTitle.trim(),
        desc: _enteredBody.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: "Add Notes",
          backButton: _back,
          finalFunc: _onSave,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onSaved: (value) {
                    _enteredTitle = value!.trim().toString();
                  },
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    counterText: "",
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      letterSpacing: 0.3,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    _enteredBody = value!.trim().toString();
                  },
                  keyboardType: TextInputType.text,
                  maxLines: 100,
                  minLines: 15,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Colors.black87),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    hintText: "Description",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      // fontSize: 20,
                      letterSpacing: 0.3,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
