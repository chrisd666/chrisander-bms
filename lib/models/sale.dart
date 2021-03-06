import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms/models/product.dart';

class Sale {
  final String? id;
  final String productId;
  final int quantity;
  final int totalPrice;
  final Timestamp? createdAt;

  Sale(
      {this.id,
      required this.productId,
      required this.quantity,
      required this.totalPrice,
      this.createdAt});

  Sale.fromJson(Map<String, Object?> json)
      : this(
            productId: json['productId']! as String,
            quantity: json['quantity']! as int,
            totalPrice: json['totalPrice']! as int,
            createdAt: json['createdAt']! as Timestamp);

  Map<String, Object?> toJson() {
    return {
      'businessId': 'nl4AolUR6ViZp3u8NbZc',
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  // static List<Sale> mockSales = [
  //   Sale(productId: "Kingfisher 750ml", quantity: 15, totalPrice: 50),
  //   Sale(productId: "Tuborg 750ml", quantity: 35, totalPrice: 50),
  //   Sale(productId: "Blender's Pride 750ml", quantity: 5, totalPrice: 50),
  //   Sale(productId: "McDowell's No 1 180ml", quantity: 67, totalPrice: 50),
  //   Sale(productId: "Old Monk 350ml", quantity: 15, totalPrice: 50),
  //   Sale(productId: "Budweiser can 350ml", quantity: 67, totalPrice: 50),
  //   Sale(productId: "Bisleri Soda 750ml", quantity: 15, totalPrice: 50),
  //   Sale(productId: "Coca Cola 1l", quantity: 3, totalPrice: 50),
  //   Sale(productId: "Teacher's Reserve 750ml", quantity: 3, totalPrice: 50),
  //   Sale(
  //       productId: "Johnny Walker Blue Label 750ml",
  //       quantity: 1,
  //       totalPrice: 50),
  // ];

  static CollectionReference salesRef =
      FirebaseFirestore.instance.collection('sales');

  Future<void> add() {
    return salesRef
        .add(toJson())
        .then((value) {})
        .catchError((error) => print("Failed to add sales: $error"));
  }

  static Future<List> findAll(List sales) async {
    List<Map<String, dynamic>> salesWithProduct = [];

    for (int i = 0; i < sales.length; i++) {
      var sale = sales[i];

      dynamic product = await Product.findOne(sale["productId"]);

      salesWithProduct.add({
        'product': product['name'],
        'unitPrice': product['unitPrice'],
        'quantity': sale['quantity'],
        'totalPrice': sale['totalPrice']
      });
    }

    return salesWithProduct;
  }

  Future<void> update() {
    return salesRef
        .doc(id)
        .update(toJson())
        .then((value) => print("Sale updated"))
        .catchError((error) => print("Failed to update sale: $error"));
  }

  static Future<void> delete(String id) {
    return salesRef
        .doc(id)
        .delete()
        .then((value) => print("Sale deleted"))
        .catchError((error) => print("Failed to delete sale: $error"));
  }
}
