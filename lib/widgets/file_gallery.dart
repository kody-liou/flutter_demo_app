import 'package:flutter/material.dart';

class GalleryView extends StatefulWidget {
  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];
  List<bool> selected = List.filled(6, false);

  int startIndex = -1;
  int endIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(6, (index) {
          return GestureDetector(
            onPanDown: (DragDownDetails details) {
              setState(() {
                startIndex = index;
                endIndex = index;
                selected[index] = true;
              });
            },
            onPanUpdate: (DragUpdateDetails details) {
              final obj = context.findRenderObject();
              if (obj is RenderBox) {
                final RenderBox box = obj;
                final Offset localPosition =
                    box.globalToLocal(details.globalPosition);
                final int newIndex =
                    (localPosition.dy ~/ (box.size.height / 3)) * 3 +
                        (localPosition.dx ~/ (box.size.width / 3));
                if (newIndex != endIndex && newIndex < 6) {
                  setState(() {
                    endIndex = newIndex;
                    for (int i = startIndex; i <= endIndex; i++) {
                      selected[i] = true;
                    }
                  });
                }
              }
            },
            onPanEnd: (DragEndDetails details) {
              setState(() {
                startIndex = -1;
                endIndex = -1;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: colors[index],
                border: selected[index]
                    ? Border.all(color: Colors.red, width: 2)
                    : Border.all(color: Colors.transparent, width: 2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
