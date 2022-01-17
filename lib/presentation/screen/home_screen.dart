import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';
import 'package:flutter_keep_google/core/constant/app_route.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/presentation/screen/note.dart';
import 'package:flutter_keep_google/presentation/screen/search_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/widget/note_iteam.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController noteController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    noteController.loadNoteAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                flexibleSpace: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 1)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => SearchScreen());
                                },
                                child: const Text('Search your notes'))
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.manage_search_rounded),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'PINNED',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              itemCount: noteController.listNotePin.length,
                              itemBuilder: (BuildContext context, int index) {
                                return NoteIteam(
                                  color: Color(noteController
                                      .listNotePin[index].colorInt),
                                  title:
                                      noteController.listNotePin[index].title,
                                  description:
                                      noteController.listNotePin[index].note,
                                  onTap: () {
                                    noteController.editNote(
                                      noteController.listNotePin[index],
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
                    )),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'OTHERS',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              itemCount: noteController.listNoteUnPin.length,
                              itemBuilder: (BuildContext context, int index) {
                                return NoteIteam(
                                  color: Color(noteController
                                      .listNoteUnPin[index].colorInt),
                                  title:
                                      noteController.listNoteUnPin[index].title,
                                  description:
                                      noteController.listNoteUnPin[index].note,
                                  onTap: () {
                                    noteController.editNote(
                                      noteController.listNoteUnPin[index],
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
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_box_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.colorize_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic_none_rounded,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.photo_camera_back_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              const NoteScreen(
                transactionAction: TransactionAction.add,
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.red,
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Google Keep',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(height: 1, color: Colors.grey[300]),
                Flexible(
                    child: ListView(
                  children: [
                    const ListTile(
                        leading: Icon(Icons.lightbulb_outline),
                        title: Text('Notes')),
                    const ListTile(
                      leading: Icon(Icons.notifications_none_outlined),
                      title: Text('Reminders'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Container(height: 1, color: Colors.grey[300]),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'LABELS',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.label_outline),
                      title: Text('Daily Task'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.label_outline),
                      title: Text('Diary'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.label_outline),
                      title: Text('Work Task'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.create_outlined),
                      title: Text('Create/Edit labels'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Container(height: 1, color: Colors.grey[300]),
                    ),
                    const ListTile(
                      leading: Icon(Icons.archive_outlined),
                      title: Text('Archive'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Trash'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Container(height: 1, color: Colors.grey[300]),
                    ),
                    const ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Settings'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.feedback_outlined),
                      title: Text('Send app feedback'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.help_center_outlined),
                      title: Text('Help'),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }
}
