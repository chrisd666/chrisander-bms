import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  final String? id;
  final String productId;
  final String businessId;
  final int quantity;
  final int openingBalance;
  final int closingBalance;

  Inventory(
      {this.id,
      required this.productId,
      required this.quantity,
      required this.openingBalance,
      required this.closingBalance,
      required this.businessId});

  Inventory.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          businessId: json['businessId']! as String,
          productId: json['productId']! as String,
          quantity: json['quantity']! as int,
          openingBalance: json['openingBalance']! as int,
          closingBalance: json['closingBalance']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'businessId': businessId,
      'productId': productId,
      'quantity': quantity,
      'openingBalance': openingBalance,
      'closingBalance': closingBalance,
    };
  }

  static CollectionReference inventoryRef = FirebaseFirestore.instance
      .collection('inventories')
      .withConverter<Inventory>(
          fromFirestore: (snapshot, _) => Inventory.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());

  Future<bool> add() {
    return inventoryRef
        .add(this)
        .then((value) => true)
        .catchError((error) => {print("Failed to add inventory log: $error")});
  }

  // static findOne(String id) async {
  //   return productsRef.doc(id).get().then((value) {
  //     return {
  //       "name": value['name'],
  //       'unitsInStock': value['unitsInStock'],
  //       'unitPrice': value['unitPrice']
  //     };
  //   }).catchError((error) => print("Failed to find product: $error"));
  // }

  static findFirst(String field, dynamic value) async {
    return inventoryRef
        .where(field, isEqualTo: value)
        .get()
        .then((value) => value.docs)
        .catchError((error) => print("Failed to find inventory log: $error"));
  }

  // static Future<void> update(String id, Map<String, Object> data) {
  //   return productsRef
  //       .doc(id)
  //       .update(data)
  //       .then((value) => print("Product updated"))
  //       .catchError((error) => print("Failed to update product: $error"));
  // }

  // static Future<void> delete(String id) {
  //   return productsRef
  //       .doc(id)
  //       .delete()
  //       .then((value) => print("Product deleted"))
  //       .catchError((error) => print("Failed to delete product: $error"));
  // }
}
