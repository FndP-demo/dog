import 'package:dog/networking/bloc/get_breed_list_bloc.dart';
import 'package:dog/networking/bloc/get_random_image_bloc.dart';
import 'package:dog/networking/models/breed_images_response.dart';
import 'package:dog/networking/response.dart';
import 'package:dog/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'all_images.dart';
import 'image_view.dart';

class SubBreedScreen extends StatefulWidget {
  String breedName = "";

  SubBreedScreen({required this.breedName, Key? key}) : super(key: key);

  @override
  _SubBreedScreenState createState() => _SubBreedScreenState();
}

class _SubBreedScreenState extends State<SubBreedScreen> {
  late GetBreedListBloc getBreedListBloc;
  ImageByBreedResponse? imageByBreedResponse;
  ImageByBreedResponse? subBreedsResponse;

  @override
  void initState() {
    super.initState();

    getBreedListBloc = GetBreedListBloc();

    getBreedListBloc.breedImagesDataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          setState(() {
            imageByBreedResponse = event.data!;
          });
          break;
        case Status.ERROR:
          break;
      }
    });

    getBreedListBloc.subBreedDataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          setState(() {
            subBreedsResponse = event.data!;
          });
          break;
        case Status.ERROR:
          break;
      }
    });

    getBreedListBloc.getImageByBreedList(widget.breedName);
    getBreedListBloc.getSubListByBreed(widget.breedName);
  }

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
          widget.breedName.toCapitalized(),
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (imageByBreedResponse != null)
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: ImageViewScreen(
                imageByBreedResponse: imageByBreedResponse!,
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              'Tap on a sub breed to view more pictures',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subBreedsResponse != null &&
                      subBreedsResponse!.message!.isNotEmpty
                  ? subBreedsResponse!.message!.length
                  : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    ///navigate to images screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllImagesBySubBreed(
                          breedName: subBreedsResponse!.message![index],
                          imageByBreedResponse: imageByBreedResponse!,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    subBreedsResponse!.message![index].toCapitalized(),
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
