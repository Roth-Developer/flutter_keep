import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/screen/home_screen.dart';
import 'package:flutter_keep_google/presentation/screen/note.dart';
import 'package:flutter_keep_google/presentation/screen/search_with_color.dart';
import 'package:flutter_keep_google/presentation/widget/my_card.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:flutter_keep_google/presentation/widget/note_iteam.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController tecSearch;
  late FocusNode fnSearch;
  final NoteController noteController = Get.find();

  @override
  void initState() {
    tecSearch = TextEditingController();
    fnSearch = FocusNode();
    fnSearch.requestFocus();
    noteController.listSearchNote.clear();

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
            if (tecSearch.text == '' && noteController.listSearchNote.isEmpty) {
              Get.to(
                () => const HomeScreen(),
              );
            } else {
              setState(() {
                tecSearch.clear();
                noteController.listSearchNote.clear();
              });
            }
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: MyTextField(
          onChange: (x) {
            setState(() {
              noteController.searchNote(x);
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
              visible: noteController.listSearchNote.isNotEmpty ? true : false,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: noteController.listSearchNote.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteIteam(
                          color: Color(
                              noteController.listSearchNote[index].colorInt),
                          title: noteController.listSearchNote[index].title,
                          description:
                              noteController.listSearchNote[index].note,
                          onTap: () {
                            noteController.editNote(
                              noteController.listSearchNote[index],
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
              visible:
                  noteController.listSearchNote.isEmpty && tecSearch.text == ''
                      ? true
                      : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        bottom: 15, left: 15, right: 15, top: 15),
                    child: Text('Types'),
                  ),
                  Row(
                    children: const [
                      MyCard(
                        icon: Icons.check_box_outlined,
                        iconColor: Colors.blue,
                        text: 'Lists',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.photo_camera_back_outlined,
                        iconColor: Colors.blue,
                        text: 'Images',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.colorize_outlined,
                        iconColor: Colors.blue,
                        text: 'Drawings',
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Labels'),
                  ),
                  Row(
                    children: const [
                      MyCard(
                        icon: Icons.label_outline,
                        iconColor: Colors.blue,
                        text: 'Daily Task',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.label_outline,
                        iconColor: Colors.blue,
                        text: 'Work task',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.label_outline,
                        iconColor: Colors.blue,
                        text: 'Entertainment',
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Things'),
                  ),
                  Row(
                    children: const [
                      MyCard(
                        icon: Icons.fastfood_outlined,
                        iconColor: Colors.blue,
                        text: 'Food',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.place_outlined,
                        iconColor: Colors.blue,
                        text: 'Place',
                      ),
                      SizedBox(width: 5),
                      MyCard(
                        icon: Icons.airplanemode_active_outlined,
                        iconColor: Colors.blue,
                        text: 'Travel',
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Colors'),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: AppColor.listNoteBackGroundColor
                          .map((x) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   noteController.searchColorNote(x.value);
                                    // });
                                    Get.to(() => SearchWithColorScreen(
                                          color: x.value,
                                        ));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.purple,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.black,
                                      radius: 18,
                                      backgroundColor: x,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible:
                  noteController.listSearchNote.isEmpty && tecSearch.text != ''
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
