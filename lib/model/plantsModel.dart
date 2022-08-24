// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:le_vie_app/model/blogs.dart';

import '../shared/database/database.dart';

class Products {
  String? type;
  String? message;
  List<Product>? data;

  Products({type, message, data});

  Products.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
     
     if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add( Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataa =  <String, dynamic>{};
    dataa['type'] = type;
    dataa['message'] = message;
    if (data != null) {
      dataa['plants'] = data!.map((v) => v.toJson()).toList();
    }
    return dataa;
  }
}

class Product {
  String? id;
  String? name;
  String? description;
  String? imageurl;
  String? type;
  int? price;
  Plant? plant;
  Seed? seed;
  Tool? tool;
  int indx=1;
  DataBase db=DataBase();
  Product(
      {id,
      name,
      description,
      imageurl,
      type,
      price,
      plant,
      seed,
      tool});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['productId'];
    name = json['name'];
    description = json['description'];
    imageurl = json['imageUrl'];
    type = json['type'];
    price = json['price'];
    plant = json['plant'] != null ?  Plant.fromJson(json['plant']) : null;
    seed = json['seed'] != null ?  Seed.fromJson(json['seed']) : null;
    tool = json['tool'] != null ?  Tool.fromJson(json['tool']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['productId'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageurl'] = imageurl;
    data['type'] = type;
    data['price'] = price;
    if (plant != null) {
      data['plant'] = plant!.toJson();
    }
    if (seed != null) {
      data['seed'] = seed!.toJson();
    }
    if (tool != null) {
      data['tool'] = tool!.toJson();
    }
    return data;
  }
  addToFav()async{
    await db.insertFavProduct(this);
  }
   deletfromFav()async{
    await db.deletFavProduct(this);
  }
  update()async{
    await db.updateProduct(this);
  }
}