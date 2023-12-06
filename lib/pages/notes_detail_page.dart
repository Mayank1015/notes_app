import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/utils/custom_app_bar.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({Key? key, required this.note}) : super(key: key);

  final NotesModel note;

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  final _formKey = GlobalKey<FormState>();
  int totalBodyCharLength = 0;
  String _enteredTitle = "";
  String _enteredBody = "";

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _descController.text = widget.note.desc;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _onEdit() {
    _formKey.currentState!.save();
    if (_enteredBody.isEmpty && _enteredTitle.isEmpty) {
      Navigator.of(context).pop();
    } else if (_enteredTitle.isEmpty && _enteredBody.isNotEmpty) {
      NotesModel data = NotesModel(
        id: widget.note.id,
        title: "Untitled",
        desc: _descController.text.trim(),
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
        id: widget.note.id,
        title: _titleController.text.trim(),
        desc: _descController.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: "Edit Notes",
          backButton: _back,
          finalFunc: _onEdit,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onSaved: (value) {
                    _enteredTitle = value!.trim().toString();
                  },
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
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
                  controller: _descController,
                  keyboardType: TextInputType.text,
                  maxLines: 100,
                  minLines: 15,
                  style: const TextStyle(color: Colors.black87),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
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
