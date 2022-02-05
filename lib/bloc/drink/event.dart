import 'package:equatable/equatable.dart';
import 'package:test_flutter/database/database.dart';

abstract class DrinkEvent extends Equatable {
  const DrinkEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends DrinkEvent {
  const InitEvent();
}

class GetDrinksList extends DrinkEvent {
  final bool showLoading;

  const GetDrinksList({this.showLoading = true});

  @override
  List<Object?> get props => [showLoading];
}

class AddNewDrink extends DrinkEvent {
  final Drink drink;

  const AddNewDrink(this.drink);

  @override
  List<Object?> get props => [drink];
}

class DeleteDrinkEvent extends DrinkEvent {
  final Drink drink;
  final int index;

  const DeleteDrinkEvent(this.drink, this.index);

  @override
  List<Object?> get props => [drink,index];
}