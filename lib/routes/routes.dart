import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_bloc/data/model/product_model.dart';
import 'package:online_shop_bloc/pages/cart/screens/cart_screen.dart';
import 'package:online_shop_bloc/pages/detail/screen/detail_screen.dart';
import 'package:online_shop_bloc/pages/home/bloc/home_bloc.dart';
import 'package:online_shop_bloc/pages/home/screens/home_screen.dart';
import 'package:online_shop_bloc/routes/routes_url.dart';

final router = GoRouter(routes: [
  GoRoute(
      path: '/',
      name: AppRoute.homePage,
      builder: (context, state) => BlocProvider(
            create: (context) => HomeBloc()..add(LoadProduct()),
            child: HomeScreen(),
          ),
      routes: [
        GoRoute(
            path: '/detail',
            name: AppRoute.detailProduct,
            builder: (context, state) => DetailScreen(
                  product: state.extra as Product,
                )),
        GoRoute(
            path: '/cart',
            name: AppRoute.cart,
            builder: (context, state) => const CartScreen())
      ])
]);
