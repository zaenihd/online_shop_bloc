part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddQuantityEvent extends CartEvent{}
