import 'package:uuid/uuid.dart';

const uuid = Uuid();

class NotesModel {
  final String id;
  final String title;
  final String desc;

  NotesModel({
    required this.id,
    required this.title,
    required this.desc,
  });

  factory NotesModel.fromMap(Map<String, dynamic> res) => NotesModel(
        id: res['id'],
        title: res['title'],
        desc: res['desc'],
      );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
    };
  }
}
