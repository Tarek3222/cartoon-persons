import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters.dart';

class BuildSingleCharacter extends StatelessWidget {
  const BuildSingleCharacter({super.key, required this.character});
  final CharactersModel character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, characterDetailsView,
            arguments: character);
      },
      child: Container(
        margin:
            const EdgeInsetsDirectional.only(start: 6, end: 6, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.myGrey,
          border: Border.all(color: AppColors.myWhite,width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridTile(
          footer: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: AlignmentDirectional.bottomCenter,
            decoration:const BoxDecoration(
              color: Colors.black54,
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              character.name!,
              style: const TextStyle(
                color: AppColors.myWhite,
                height: 1.3,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child: Hero(
            tag: character.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:character.image != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/animations/loading.gif',
                      image: character.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
