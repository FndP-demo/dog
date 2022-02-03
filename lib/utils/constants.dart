import 'package:flutter/material.dart';


var baseUrl = "https://dog.ceo/api/";

///api end points

///get breed list
String getAllBreedsListUrl = "breeds/list/all";

///get random image
String getRandomDogUrl  = "breeds/image/random";

///by breed
String getSubBreedListUrl = "breed/";

String getCountryUrl = "/breeds/list/all";


String noInternet = "No Internet";

void onLoading(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.5),
    // background color
    barrierDismissible: false,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return SizedBox.expand(
        // makes widget fullscreen
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Lottie.asset('assets/loader.json', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)
            ],
          ),
        ),
      );
    },
  );
}

void stopLoader(BuildContext context) {
  Navigator.pop(context);
}

printLog(var msg) {
  print(msg);
}

String strErrorRequiredField = "'Required field(s) can\'t be empty'";

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
