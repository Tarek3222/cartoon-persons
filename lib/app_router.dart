// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_persons/bussnies_logic/characters_cubit/characters_cubit.dart';
import 'package:movies_persons/constants/strings.dart';
import 'package:movies_persons/data/models/characters.dart';
import 'package:movies_persons/data/repo/characters_repo.dart';
import 'package:movies_persons/data/services/api_services.dart';
import 'package:movies_persons/presentation/views/character_details_view.dart';
import 'package:movies_persons/presentation/views/characters_view.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepo = CharactersRepo(apiServices: ApiServices());
    charactersCubit = CharactersCubit(charactersRepo);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersView(),
          ),
        );
      case characterDetailsView:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
          builder: (_) =>  CharacterDetailsView(
            character: character,
          ),
        );
    }
  }
}
