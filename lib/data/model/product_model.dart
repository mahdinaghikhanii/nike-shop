class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHeightLow = 2;
  static const int proceLowTohight = 3;
}

class ProductEntity {
  int? id;
  String? title;
  int? price;
  int? discount;
  String? image;
  int? status;
  int? previousPrice;

  ProductEntity(
      {this.id,
      this.title,
      this.price,
      this.discount,
      this.image,
      this.status,
      this.previousPrice});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    status = json['status'];
    previousPrice = json['previous_price'];
  }
}
