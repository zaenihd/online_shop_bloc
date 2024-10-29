import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_bloc/data/model/product_model.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: double.maxFinite,
            imageUrl: product.images![0],
            imageBuilder: (context, imageProvider) {
              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            product.title!,
            style: const TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Text(
            "\$ ${product.price}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.grey),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: const Icon(Icons.add_shopping_cart_outlined),
      ),
    );
  }
}
