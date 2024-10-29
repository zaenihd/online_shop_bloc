import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_bloc/pages/home/bloc/home_bloc.dart';
import 'package:online_shop_bloc/routes/routes.dart';
import 'package:online_shop_bloc/routes/routes_url.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchC = TextEditingController();
  List images = [
    'https://cdn.shopify.com/s/files/1/0070/7032/articles/trending-products_7ed711c4-206c-4b41-a321-711785f3a917.png?v=1729280622',
    "https://hips.hearstapps.com/hmg-prod/images/gh-best-skincare-products-6557978b58b57.png?crop=0.888888888888889xw:1xh;center,top&resize=1200:*",
    "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-06/240610-beauty-awards-2024-skincare-winners-vl-social-91be20.jpg",
    "https://theskincarecompany.com.au/wp-content/uploads/2021/01/TSC-Jul202-768x512.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                context.goNamed(AppRoute.cart);
              }, icon: const Icon(Icons.shopping_cart_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchC,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < images.length; i++)
                    InkWell(
                      onTap: () {
                        // context.read<HomeBloc>().add(LoadProduct());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(images[i]),
                                fit: BoxFit.cover)),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            _products(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _products() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 109.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.0,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: state.products.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final product = state.products[index];
              return InkWell(
                onTap: () {
                  context.goNamed(AppRoute.detailProduct, extra: product);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: double.maxFinite,
                        imageUrl: product.images![0],
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        product.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "\$ ${product.price}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is HomeError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}
