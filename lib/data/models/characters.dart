class CharactersModel {
  int? id;
  String? name;
  String? location;
  String? statusIfDeadOrAlive;
  String? image;
  String? species;
  String? gender;
  String? originName;

  CharactersModel( 
    {this.id, 
    this.name, 
    this.location, 
    this.statusIfDeadOrAlive, 
    this.image, 
    this.species, 
    this.gender, 
    this.originName}
    );

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      location: json['location']['name'] as String?,
      statusIfDeadOrAlive: json['status']  as String?,
      image: json['image'] as String?,
      species: json['species'] as String?,
      gender: json['gender']  as String?,
      originName: json['origin']['name'] as String?,
    );
  }
}