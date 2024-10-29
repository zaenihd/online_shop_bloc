import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:online_shop_bloc/data/model/product_model.dart';

class Datasource {
  final dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com/products"));

  Future<ProductsModel>getProducts() async {
    final data = await dio.get("");

    return productsModelFromJson(data.toString());
  }
}
