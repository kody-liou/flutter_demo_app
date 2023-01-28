import 'dart:io';
import 'package:flutter/material.dart';

class FileGallery extends StatefulWidget {
  final List<File> files;

  const FileGallery({super.key, required this.files});

  @override
  _FileGalleryState createState() => _FileGalleryState();
}

class _FileGalleryState extends State<FileGallery> {
  final Set<File> _selectedFiles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Gallery"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Do something with the selected files
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: widget.files.length,
        itemBuilder: (BuildContext context, int index) {
          File file = widget.files[index];
          return Stack(
            children: <Widget>[
              // Image preview
              Positioned.fill(
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
              // Selection overlay
              Positioned.fill(
                child: _selectedFiles.contains(file)
                    ? Container(
                        color: Colors.black12,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : Container(),
              ),
              // Gesture detector
              Positioned.fill(
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _selectedFiles.add(file);
                    });
                  },
                  onLongPressEnd: (details) {
                    setState(() {
                      _selectedFiles.remove(file);
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
