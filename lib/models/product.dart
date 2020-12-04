import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //Constants
  static const String ID = 'id';
  static const String CATEGORY = 'category';
  static const String NAME = 'name';
  static const String PRICE = 'price';
  static const String BRAND = 'brand';
  static const String COLORS = 'colors';
  static const String QUANTITY = 'quantity';
  static const String SIZE = 'size';
  static const String SALE = 'sale';
  static const String FEATURED = 'featured';
  static const String PICTURE = 'picture';

  //private variables
  String _id;
  String _category;
  String _name;
  double _price;
  String _brand;
  List<String> _colors;
  int _quantity;
  List<String> _size;
  bool _sale;
  bool _featured;
  String _picture;

  //getters
  String get id => _id;
  String get category => _category;
  String get name => _name;
  double get price => _price;
  String get brand => _brand;
  List<String> get colors => _colors;
  int get quantity => _quantity;
  List<String> get size => _size;
  bool get sale => _sale;
  bool get featured => _featured;
  String get picture => _picture;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _category = snapshot.data[CATEGORY];
    _name = snapshot.data[NAME];
    _price = snapshot.data[PRICE];
    _brand = snapshot.data[BRAND];
    _colors = snapshot.data[COLORS];
    _quantity = snapshot.data[QUANTITY];
    _size = snapshot.data[SIZE];
    _sale = snapshot.data[SALE];
    _featured = snapshot.data[FEATURED];
    _picture = snapshot.data[PICTURE];
  }
}
