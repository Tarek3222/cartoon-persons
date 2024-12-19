import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../bussnies_logic/characters_cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';
import '../widgets/build_single_character.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> seachingForCharacters;
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myYellow,
        title: isSearching ? buildSearchField() : buildTitleAppBar(),
        actions: buildAppBarActions(),
      ),
      body:  OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return charactersBodyWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.myYellow,
          ),
        ),
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            'No Connection...check your internet!',
            style: TextStyle(color: AppColors.myYellow, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Image(image: AssetImage('assets/images/offline.png')),
        ],
      ),
    );
  }

  Widget charactersBodyWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildListOfCharacters();
        } else if (state is CharactersError) {
          return Center(
            child: Text(
              state.message.toString(),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.myYellow,
            ),
          );
        }
      },
    );
  }

  Widget buildListOfCharacters() {
    return Container(
      color: AppColors.myGrey,
      height: double.infinity,
      width: double.infinity,
      alignment: searchController.text.isNotEmpty
          ? seachingForCharacters.isEmpty
              ? Alignment.center
              : null
          : null,
      child: searchController.text.isNotEmpty
          ? seachingForCharacters.isEmpty
              ? const Text(
                  'Not Found',
                  style: TextStyle(color: AppColors.myWhite, fontSize: 20),
                )
              : buildGridViewOfCharacters()
          : buildGridViewOfCharacters(),
    );
  }

  Widget buildGridViewOfCharacters() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 0.5,
      ),
      itemCount: searchController.text.isEmpty
          ? allCharacters.length
          : seachingForCharacters.length,
      itemBuilder: (context, index) {
        return BuildSingleCharacter(
          character: searchController.text.isEmpty
              ? allCharacters[index]
              : seachingForCharacters[index],
        );
      },
    );
  }

  Widget buildTitleAppBar() {
    return const Text(
      'Characters',
      style: TextStyle(color: AppColors.myGrey),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: AppColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: AppColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedItemToSearchedList(String searchedCharacter) {
    seachingForCharacters = allCharacters.where((character) {
      return character.name!
          .toLowerCase()
          .startsWith(searchedCharacter.toLowerCase());
    }).toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              searchController.clear();
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: AppColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(// like to the navigation
        LocalHistoryEntry(
      onRemove: stopSearch,
    )); // add history entry for the search and change the state of the app bar to searching اكني بعمل route جديد وبيضيف ال back button
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    searchController.clear();
    setState(() {
      isSearching = false;
    });
  }
}
