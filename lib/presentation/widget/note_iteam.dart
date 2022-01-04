import 'package:flutter/material.dart';

class NoteIteam extends StatelessWidget {
  final String? title;
  final String? description;
  final Function() onTap;

  const NoteIteam({Key? key, this.title, this.description, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                description!,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
