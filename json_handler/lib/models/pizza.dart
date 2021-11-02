class Pizza {
  int id;
  String pizzaName;
  String description;
  double price;
  String imageUrl;

  Pizza(
    this.id,
    this.pizzaName,
    this.description,
    this.price,
    this.imageUrl,
  );

  factory Pizza.fromMap(Map<String, dynamic> map) => Pizza(
        map["id"],
        map["pizzaName"],
        map["description"],
        map["price"],
        map["imageUrl"],
      );
}
