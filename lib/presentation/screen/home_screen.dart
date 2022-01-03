import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_route.dart';
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
    noteController.loadNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 5)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                          const Text('Search your notes')
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
              Obx(
                () => Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: noteController.listNote.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteIteam(
                        title: noteController.listNote[index].title,
                        description: noteController.listNote[index].note,
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        const StaggeredTile.fit(1),
                  ),
                ),
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
            Get.toNamed(AppRoute.addNote);
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
