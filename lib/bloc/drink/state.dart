import 'package:equatable/equatable.dart';
import 'package:test_flutter/database/database.dart';
import 'package:test_flutter/model/error_model.dart';

abstract class DrinkState extends Equatable {
  const DrinkState();

  @override
  List<Object?> get props => [];
}

class InitState extends DrinkState {
  const InitState();
}

class LoadingState extends DrinkState {
  const LoadingState();
}

class DrinksloadedState extends DrinkState {
  final List<Drink> drinks;

  const DrinksloadedState(this.drinks);

  @override
  List<Object?> get props => [drinks];
}

class DrinkDeletingState extends DrinkState {
  const DrinkDeletingState();
}

class DrinkAddingState extends DrinkState {
  const DrinkAddingState();
}

class DrinkAddedState extends DrinkState {
  const DrinkAddedState();
}

class DrinkDeletedState extends DrinkState {
  final int index;

  const DrinkDeletedState(this.index);

  @override
  List<Object?> get props => [index];
}

class ErrorState extends DrinkState {
  final ErrorModel errorModel;
  final bool showToast;

  const ErrorState(this.errorModel, {this.showToast = true});

  @override
  List<Object?> get props => [errorModel, showToast];
}
