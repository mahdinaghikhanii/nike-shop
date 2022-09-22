class BannerEntity {
  int? id;
  String? image;

  BannerEntity({this.id, this.image});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
