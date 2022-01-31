import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String name;
  final int quantity;
  final int price;

  Product(
      {this.id,
      required this.name,
      required this.quantity,
      required this.price});

  Product.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            quantity: json['quantity']! as int,
            price: json['price']! as int);

  Map<String, Object?> toJson() {
    return {'name': name, 'quantity': quantity, 'price': price};
  }

  static List<Product> mockProducts = [
    Product(name: "Kingfisher 750ml", quantity: 15, price: 50),
    Product(name: "Tuborg 750ml", quantity: 35, price: 50),
    Product(name: "Blender's Pride 750ml", quantity: 5, price: 50),
    Product(name: "McDowell's No 1 180ml", quantity: 67, price: 50),
    Product(name: "Old Monk 350ml", quantity: 15, price: 50),
    Product(name: "Budweiser can 350ml", quantity: 67, price: 50),
    Product(name: "Bisleri Soda 750ml", quantity: 15, price: 50),
    Product(name: "Coca Cola 1l", quantity: 3, price: 50),
    Product(name: "Teacher's Reserve 750ml", quantity: 3, price: 50),
    Product(name: "Johnny Walker Blue Label 750ml", quantity: 1, price: 50),
  ];

  static CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');
  // .withConverter<Product>(
  //     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
  //     toFirestore: (product, _) => product.toJson());

  Future<void> add() {
    return productsRef
        .add(toJson())
        .then((value) => print("Product added"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future<void> update() {
    return productsRef
        .doc(id)
        .update(toJson())
        .then((value) => print("Product updated"))
        .catchError((error) => print("Failed to update product: $error"));
  }

  static Future<void> delete(String id) {
    return productsRef
        .doc(id)
        .delete()
        .then((value) => print("Product deleted"))
        .catchError((error) => print("Failed to delete product: $error"));
  }
}
