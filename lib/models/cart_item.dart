class CartItem {
  int? id;
  String? title;
  String? imageUrl;
  double? price;
  int? quantity;

  CartItem({
    this.id,
    this.title,
    this.imageUrl,
    this.price,
    this.quantity,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image-url'];
    price = json['price'].toDouble();
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image-url': imageUrl,
        'price': price,
        'quantity': quantity,
      };
}
