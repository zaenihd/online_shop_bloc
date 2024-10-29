
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop_bloc/data/datasource/datasource.dart';
import 'package:online_shop_bloc/data/model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    Datasource data = Datasource();
    on<HomeEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final products = await data.getProducts();
        emit(HomeLoaded(products: products.products!));
      } catch (e) {
        log('message $e');
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
