import 'dart:io';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({Key? key, required this.text,required this.showImage,this.img}): super(key: key);
  final bool showImage;
  File? img;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        64.0,
        4,
        16.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: Alignment.centerRight,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
                (showImage && img!=null )? Image.file(img!) : Container(),
              ]
            )
          ),
        ),
      ),
    );
  }
}
