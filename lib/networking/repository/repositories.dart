import 'package:dog/networking/models/breed_images_response.dart';
import 'package:dog/networking/models/all_breed_response.dart';
import 'package:dog/networking/models/random_image_response.dart';
import 'package:dog/networking/apiprovider.dart';
import '../../utils/constants.dart';
import '../apiprovider.dart';

class GetRandomImageRepository{
  final ApiProvider _apiProvider = ApiProvider();
  Future<RandomImageResponse> getRandomImage() async {
    final response = await _apiProvider.get(getRandomDogUrl);
    return RandomImageResponse.fromJson(response);
  }
}
class GetBreedListRepository{
  final ApiProvider _apiProvider = ApiProvider();
  Future<AllBreedResponse> getBreedList() async {
    final response = await _apiProvider.get(getAllBreedsListUrl);
    return AllBreedResponse.fromJson(response);
  }

  Future<ImageByBreedResponse> getImageByBreedList(String breedName) async {
    final response = await _apiProvider.get(getSubBreedListUrl+breedName+"/images");
    return ImageByBreedResponse.fromJson(response);
  }

  Future<ImageByBreedResponse> getSubListByBreed(String breedName) async {
    final response = await _apiProvider.get(getSubBreedListUrl+breedName+"/list");
    return ImageByBreedResponse.fromJson(response);
  }
}
