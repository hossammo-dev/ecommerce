class ProductModel {
  int? id;
  String? title;
  String? description;
  String? category;
  String? imageUrl;
  double? price;
  double? rate;
  bool? isFavorited = false;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.imageUrl,
    this.price,
    this.rate,
    this.isFavorited,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    imageUrl = json['image'];
    price = json['price'].toDouble();
    rate = json['rating']['rate'].toDouble();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'image': imageUrl,
        'price': price,
        'rate': rate,
      };
}
