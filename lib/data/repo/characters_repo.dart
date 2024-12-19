import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/characters.dart';
import '../services/api_services.dart';
import '../services/failure.dart';

class CharactersRepo {
  final ApiServices apiServices;

  CharactersRepo({required this.apiServices});

  Future<Either<Failure, List<CharactersModel>>> getAllCharacters() async {
    try {
      var data = await apiServices.getAllCharacters();
      List<dynamic> characters = data['results'];
      List<CharactersModel> allCharacters = characters
          .map((character) => CharactersModel.fromJson(character))
          .toList();
      return right(allCharacters);
    } on DioException catch (e) {
      return left(
        ServerFailure.fromDioError(e),
      );
    } catch (e) {
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
