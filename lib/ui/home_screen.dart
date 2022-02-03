import 'package:dog/networking/bloc/get_breed_list_bloc.dart';
import 'package:dog/networking/bloc/get_random_image_bloc.dart';
import 'package:dog/networking/models/all_breed_response.dart';
import 'package:dog/networking/models/random_image_response.dart';
import 'package:dog/networking/response.dart';
import 'package:dog/ui/sub_breed_screen.dart';
import 'package:dog/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetRandomImageBloc getRandomImageBloc;
  late GetBreedListBloc getBreedListBloc;
  RandomImageResponse? randomImageResponse;
  AllBreedResponse? allBreedResponse;

  @override
  void initState() {
    super.initState();

    getRandomImageBloc = GetRandomImageBloc();
    getBreedListBloc = GetBreedListBloc();

    getRandomImageBloc.dataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          setState(() {
            randomImageResponse = event.data!;
          });
          break;
        case Status.ERROR:
          break;
      }
    });

    getBreedListBloc.dataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          setState(() {
            allBreedResponse = event.data!;
          });
          break;
        case Status.ERROR:
          break;
      }
    });

    getRandomImageBloc.getRandomImge();
    getBreedListBloc.getBreedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dog App',
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (randomImageResponse != null &&
              randomImageResponse!.message != null)
            Image.network(
              randomImageResponse!.message!,
              fit: BoxFit.fitWidth,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          Text(
            'Random Dog of the Day',
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Tap on a breed to view more pictures',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                if(allBreedResponse!=null && allBreedResponse!.message!=null)
                for (String value in allBreedResponse!.message!.keys.toList())
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubBreedScreen(
                            breedName: value,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      value.toString().toCapitalized(),
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
