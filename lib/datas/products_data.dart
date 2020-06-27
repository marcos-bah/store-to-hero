import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;

  String title;
  String description;

  double price;

  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot s) {
    id = s.documentID;
    title = s.data['title'];
    description = s.data['description'];
    price = s.data['price'] + 0.0;
    images = s.data['images'];
    sizes = s.data['sizes'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
    };
  }
}
