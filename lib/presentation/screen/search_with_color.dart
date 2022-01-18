import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/screen/home_screen.dart';
import 'package:flutter_keep_google/presentation/screen/note.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:flutter_keep_google/presentation/widget/note_iteam.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchWithColorScreen extends StatefulWidget {
  final int color;
  const SearchWithColorScreen({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  _SearchWithColorScreenState createState() => _SearchWithColorScreenState();
}

class _SearchWithColorScreenState extends State<SearchWithColorScreen> {
  late TextEditingController tecSearch;
  late FocusNode fnSearch;

  final NoteController noteController = Get.find();

  @override
  void initState() {
    tecSearch = TextEditingController();
    fnSearch = FocusNode();
    fnSearch.requestFocus();
    noteController.searchNoteWithColor(
        textSearchWithColor: '', color: widget.color);
    super.initState();
  }

  @override
  void dispose() {
    tecSearch.dispose();
    fnSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (tecSearch.text == '' &&
                noteController.listSearchNoteWithColor.isEmpty) {
              Get.to(
                () => const HomeScreen(),
              );
            } else {
              setState(() {
                tecSearch.clear();
                noteController.listSearchNoteWithColor.clear();
                Get.back();
              });
            }
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: MyTextField(
          onChange: (x) {
            setState(() {
              noteController.searchNoteWithColor(
                  textSearchWithColor: x, color: widget.color);
            });
          },
          focusNode: fnSearch,
          text: 'Search Google Keep',
          controller: tecSearch,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: noteController.listSearchNoteWithColor.isNotEmpty
                  ? true
                  : false,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: noteController.listSearchNoteWithColor.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteIteam(
                          color: Color(noteController
                              .listSearchNoteWithColor[index].colorInt),
                          title: noteController
                              .listSearchNoteWithColor[index].title,
                          description: noteController
                              .listSearchNoteWithColor[index].note,
                          onTap: () {
                            noteController.editNote(
                              noteController.listSearchNoteWithColor[index],
                            );
                            Get.to(const NoteScreen(
                              transactionAction: TransactionAction.edit,
                            ));
                          },
                        );
                      },
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(1),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: noteController.listSearchNoteWithColor.isEmpty &&
                      tecSearch.text != ''
                  ? true
                  : false,
              child: SizedBox(
                height: Get.height - 200,
                width: Get.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_rounded,
                        size: 100,
                      ),
                      Text(
                        'No matching notes',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
