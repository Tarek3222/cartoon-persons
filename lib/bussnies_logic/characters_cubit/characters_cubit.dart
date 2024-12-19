import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/characters.dart';
import '../../data/repo/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepo) : super(CharactersInitial());
  final CharactersRepo charactersRepo;
  List<CharactersModel> allCharacters = [];
  Future<void> getAllCharacters() async {
    emit(CharactersLoading());
    final result = await charactersRepo.getAllCharacters();
    result.fold((failure) {
      emit(
        CharactersError(
          failure.errorMessage,
        ),
      );
    }, (characters) {
      emit(CharactersLoaded(characters));
      allCharacters = characters;
    });
  }
}
