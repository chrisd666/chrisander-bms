import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String name;
  final int unitsInStock;
  final int unitPrice;

  Product(
      {this.id,
      required this.name,
      required this.unitsInStock,
      required this.unitPrice});

  Product.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            unitsInStock: json['unitsInStock']! as int,
            unitPrice: json['unitPrice']! as int);

  Map<String, Object?> toJson() {
    return {'name': name, 'unitsInStock': unitsInStock, 'unitPrice': unitPrice};
  }

  static List<Product> mockProducts = [
    Product(name: "Kingfisher 750ml", unitsInStock: 15, unitPrice: 50),
    Product(name: "Tuborg 750ml", unitsInStock: 35, unitPrice: 50),
    Product(name: "Blender's Pride 750ml", unitsInStock: 5, unitPrice: 50),
    Product(name: "McDowell's No 1 180ml", unitsInStock: 67, unitPrice: 50),
    Product(name: "Old Monk 350ml", unitsInStock: 15, unitPrice: 50),
    Product(name: "Budweiser can 350ml", unitsInStock: 67, unitPrice: 50),
    Product(name: "Bisleri Soda 750ml", unitsInStock: 15, unitPrice: 50),
    Product(name: "Coca Cola 1l", unitsInStock: 3, unitPrice: 50),
    Product(name: "Teacher's Reserve 750ml", unitsInStock: 3, unitPrice: 50),
    Product(
        name: "Johnny Walker Blue Label 750ml", unitsInStock: 1, unitPrice: 50),
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
