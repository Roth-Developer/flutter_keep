import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.grey[300],
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 35,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
