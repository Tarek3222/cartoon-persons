import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key, required this.character});
  final CharactersModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.only(left: 14, right: 14, top: 16,),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterDetails(title: 'Status : ', value: character.statusIfDeadOrAlive!),
                      buildDivider(233),
                      characterDetails(title: 'Species : ', value: character.species!),
                      buildDivider(220),
                      characterDetails(title: 'Gender : ', value: character.gender!),
                      buildDivider(225),
                      characterDetails(title: 'Origin Name : ', value: character.originName!),
                      buildDivider(180),
                      characterDetails(title: 'Location : ', value: character.location!),
                      buildDivider(219),
                     const SizedBox(
                        height: 500,
                      )
                    ],
                  ),
                )
              ] 
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return  Divider(
      color: AppColors.myYellow,
      thickness: 2.5,
      height: 30,
      endIndent: endIndent,
    );
  }

  Widget characterDetails({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.myYellow,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 550,
      pinned: true,
      stretch: true,
      leading:const BackButton(
        color: AppColors.myYellow, 
      ),
      backgroundColor: AppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name!,
          style: const TextStyle(color: AppColors.myYellow,fontWeight: FontWeight.bold,fontSize: 20),
        ),
        background: Hero(
          tag: character.id!,
          child: Image(
            image: NetworkImage(character.image!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
