
import 'package:bloc/bloc.dart';
import 'package:test_flutter/database/database.dart';
import 'package:test_flutter/model/error_model.dart';

import 'event.dart';
import 'state.dart';

class DrinkBloc extends Bloc<DrinkEvent, DrinkState> {
  DrinkBloc() : super(const InitState());
  final AppDatabase database = AppDatabase();
  @override
  Stream<DrinkState> mapEventToState(DrinkEvent event) async* {
    if (event is GetDrinksList) {
      yield* _getAllDrinks(event.showLoading);
    } else if (event is AddNewDrink) {
      yield* _addNewDrink(event.drink);
    }else if (event is DeleteDrinkEvent) {
      yield* _deleteNewDrink(event.drink,event.index);
    }

    // InitState
    else {
      yield const InitState();
    }
  }

  Stream<DrinkState> _getAllDrinks(bool showLoading) async* {
    if(showLoading) yield const LoadingState();
    var drinks = await database.getAllDrinks();
    if (drinks.isNotEmpty) {
      yield DrinksloadedState(drinks);
    } else {
      yield const ErrorState(
          ErrorModel(
              errorType: ErrorType.noItemsError,
              errorValue: "There is no drinks found!"),
          showToast: false);
    }
  }

  Stream<DrinkState> _addNewDrink(Drink drink) async* {
    yield const DrinkAddingState();
    int id = await database.insertDrink(drink);
    if (id > 0) {
      yield const DrinkAddedState();
    } else {
      yield const ErrorState(ErrorModel(
          errorType: ErrorType.other, errorValue: "There is error!"));
    }
  }

  Stream<DrinkState> _deleteNewDrink(Drink drink,int index) async* {
    yield const DrinkDeletingState();
    int id = await database.deleteDrink(drink);
    if (id > 0) {
      yield DrinkDeletedState(index);
    } else {
      yield const ErrorState(ErrorModel(
          errorType: ErrorType.other, errorValue: "There is error!"));
    }
  }
}
