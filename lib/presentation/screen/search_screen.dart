import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/widget/my_card.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController tecSearch;
  final NoteController noteController = Get.find();

  @override
  void initState() {
    tecSearch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tecSearch.dispose();
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
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: MyTextField(
          text: 'Search Google Keep',
          controller: tecSearch,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
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
                            noteController.selectColor(x);
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
          )
        ],
      ),
    );
  }
}
