import 'package:dog/networking/models/breed_images_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'full_screen_image.dart';

class ImageViewScreen extends StatefulWidget {
  ImageByBreedResponse? imageByBreedResponse;

  ImageViewScreen({required this.imageByBreedResponse, Key? key})
      : super(key: key);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView.builder(
        itemCount: widget.imageByBreedResponse != null &&
                widget.imageByBreedResponse!.message!.isNotEmpty
            ? widget.imageByBreedResponse!.message!.length
            : 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        imageUrl: widget.imageByBreedResponse!.message![index]),
                  ),
                );
              },
              child: Hero(
                  tag: 'imageHero',
                  child: Image.network(
                      widget.imageByBreedResponse!.message![index])));
        },
      ),
    );
  }
}
