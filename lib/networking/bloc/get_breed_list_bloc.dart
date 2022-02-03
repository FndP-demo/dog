import 'dart:async';
import 'package:dog/networking/models/breed_images_response.dart';
import 'package:dog/networking/models/all_breed_response.dart';
import 'package:dog/networking/repository/repositories.dart';
import 'package:dog/networking/response.dart';

class GetBreedListBloc {
  late GetBreedListRepository getBreedListRepository;
  late StreamController<Response<AllBreedResponse>> getBreedListBlocController;
  late StreamController<Response<ImageByBreedResponse>> getBreedImageListBlocController;
  late StreamController<Response<ImageByBreedResponse>> getSubBreedListBlocController;

  StreamSink<Response<AllBreedResponse>> get dataSink => getBreedListBlocController.sink;
  Stream<Response<AllBreedResponse>>get dataStream =>getBreedListBlocController.stream;

  StreamSink<Response<ImageByBreedResponse>> get breedImagesDataSink => getBreedImageListBlocController.sink;
  Stream<Response<ImageByBreedResponse>> get breedImagesDataStream => getBreedImageListBlocController.stream;

  StreamSink<Response<ImageByBreedResponse>> get subBreedDataSink => getSubBreedListBlocController.sink;
  Stream<Response<ImageByBreedResponse>> get subBreedDataStream => getSubBreedListBlocController.stream;

  GetBreedListBloc(){
    getBreedListRepository = GetBreedListRepository();
    getBreedListBlocController = StreamController<Response<AllBreedResponse>>();
    getBreedImageListBlocController = StreamController<Response<ImageByBreedResponse>>();
    getSubBreedListBlocController = StreamController<Response<ImageByBreedResponse>>();
  }

  getBreedList() async {
    dataSink.add(Response.loading("getting breed list..."));
    try{
      AllBreedResponse breed = await getBreedListRepository.getBreedList();
      dataSink.add(Response.completed(breed));
    }
    catch(e){
      dataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  getImageByBreedList(String breedName) async {
    breedImagesDataSink.add(Response.loading("getting breed image list..."));
    try{
      ImageByBreedResponse breed = await getBreedListRepository.getImageByBreedList(breedName);
      breedImagesDataSink.add(Response.completed(breed));
    }
    catch(e){
      breedImagesDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  getSubListByBreed(String breedName) async {
    subBreedDataSink.add(Response.loading("getting sub breed list..."));
    try{
      ImageByBreedResponse breed = await getBreedListRepository.getSubListByBreed(breedName);
      subBreedDataSink.add(Response.completed(breed));
    }
    catch(e){
      subBreedDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  dispose(){
    getBreedListBlocController.close();
    getBreedImageListBlocController.close();
    getSubBreedListBlocController.close();
  }
}