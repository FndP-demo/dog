import 'dart:async';

import 'package:dog/networking/models/random_image_response.dart';

import '../repository/repositories.dart';
import '../response.dart';

class GetRandomImageBloc {
  late GetRandomImageRepository getRandomImageRepository;
  late StreamController<Response<RandomImageResponse>> getRandomImageBlocController;

  StreamSink<Response<RandomImageResponse>> get dataSink => getRandomImageBlocController.sink;

  Stream<Response<RandomImageResponse>> get dataStream => getRandomImageBlocController.stream;

  GetRandomImageBloc() {
    getRandomImageRepository = GetRandomImageRepository();
    getRandomImageBlocController = StreamController<Response<RandomImageResponse>>();
  }

  getRandomImge() async {
    dataSink.add(Response.loading("getting random image..."));
    try {
      RandomImageResponse randomImageResponse = await getRandomImageRepository.getRandomImage();
      dataSink.add(Response.completed(randomImageResponse));
    } catch (e) {
      dataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  dispose() {
    getRandomImageBlocController.close();
  }
}
