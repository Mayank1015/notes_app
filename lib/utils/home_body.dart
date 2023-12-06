import 'notes_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/services/provider.dart';
import 'package:notes_app/pages/notes_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class MainContent extends StatelessWidget {
  const MainContent({Key? key, required this.notesList}) : super(key: key);

  final Future<List<NotesModel>> notesList;
  final imgUrl = "assets/empty.jpg";

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesListProvider>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.getData(),
          builder: (ctx, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: AssetImage(imgUrl),
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Click "',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.3,
                              ),
                            ),
                            TextSpan(
                              text: ' + ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.yellow,
                              ),
                            ),
                            TextSpan(
                              text: '" to add new notes !',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (cx, index) {
                  return GestureDetector(
                    onTap: () async {
                      final data = await Navigator.of(context).push<NotesModel>(
                        MaterialPageRoute(
                          builder: (ctx) => NotesDetails(
                            note: NotesModel(
                              id: snapshot.data![index].id,
                              title: snapshot.data![index].title,
                              desc: snapshot.data![index].desc,
                            ),
                          ),
                        ),
                      );
                      if (data == null) {
                        return;
                      }
                      value.updateListWithProvider(data);
                    },
                    child: Dismissible(
                      key: ValueKey(snapshot.data![index]),
                      onDismissed: (direction) async {
                        final data = snapshot.data![index];
                        bool del = true;
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: const Text(
                              "Item deleted successfully",
                            ),
                            action: SnackBarAction(
                              label: "Undo",
                              textColor: Colors.yellow,
                              onPressed: () {
                                del = false;
                              },
                            ),
                          ),
                        );
                        await Future.delayed(const Duration(milliseconds: 2200));
                        if (!del) {
                          value.refresh();
                        } else {
                          value.deleteListWithProvider(data);
                        }
                      },
                      child: NotesCard(
                          title: snapshot.data![index].title,
                          desc: snapshot.data![index].desc),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        );
      },
    );
  }
}
