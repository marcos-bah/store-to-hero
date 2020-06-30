import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_to_hero/datas/products_data.dart';

class CartProduct {
  String cid;

  String category;
  String pid;

  int quantity;
  String size;
  String comment;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];
    comment = document.data["comment"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "comment": comment,
      "product": productData.toResumeMap(),
    };
  }
}
