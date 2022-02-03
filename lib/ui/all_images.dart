import 'package:dog/networking/models/breed_images_response.dart';
import 'package:dog/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'image_view.dart';

class AllImagesBySubBreed extends StatelessWidget {
  String breedName = "";
  ImageByBreedResponse imageByBreedResponse;

  AllImagesBySubBreed({required this.breedName, required this.imageByBreedResponse, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          breedName.toCapitalized(),
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
      ),
      body: ImageViewScreen(
        imageByBreedResponse: imageByBreedResponse,
      ),
    );
  }
}
