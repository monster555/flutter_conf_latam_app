import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FCLSelectImage extends StatefulWidget {
  const FCLSelectImage({required this.child, required this.onFile, super.key});
  final Widget child;
  final ValueChanged<File> onFile;

  @override
  State<FCLSelectImage> createState() => _CLlSelectImageState();
}

class _CLlSelectImageState extends State<FCLSelectImage> {
  Future<void> selectImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    widget.onFile(File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: selectImage, child: widget.child);
  }
}
