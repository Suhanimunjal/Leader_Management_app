import 'package:flutter/material.dart';

class AppBarSearchTitle extends StatelessWidget {
  final bool isSearching;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String title;
  final String hintText;

  const AppBarSearchTitle({
    Key? key,
    required this.isSearching,
    required this.controller,
    this.onChanged,
    this.title = 'Lead_Management App',
    this.hintText = 'Search leads by name / phone / email',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return TextField(
        controller: controller,
        autofocus: true,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.black,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Color.fromARGB(255, 10, 0, 0)),
      );
    }

    return Text(title);
  }
}
