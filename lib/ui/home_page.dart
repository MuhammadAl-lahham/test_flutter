import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bloc/drink/bloc.dart';
import 'package:test_flutter/bloc/drink/event.dart';
import 'package:test_flutter/bloc/drink/state.dart';
import 'package:test_flutter/common_widgets/custom_drop_down_box_widget.dart';
import 'package:test_flutter/common_widgets/custom_loading.dart';
import 'package:test_flutter/common_widgets/retry_connect_error_widget.dart';
import 'package:test_flutter/common_widgets/separater_widget.dart';
import 'package:test_flutter/database/database.dart';
import 'package:test_flutter/helper/app_colors.dart';
import 'package:test_flutter/helper/const_styles.dart';
import 'package:test_flutter/helper/font_styles.dart';
import 'package:test_flutter/helper/size_config.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/helper/toast.dart';

import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:test_flutter/model/error_model.dart';

import 'about_app/about_app_page.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DrinkBloc()..add(const GetDrinksList()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DrinkBloc>(context);

    return BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is ErrorState && state.showToast) {
            pushToast(state.errorModel.errorValue);
          } else if (state is DrinkDeletedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Drink Deleted Successfully!"),
                duration: Duration(milliseconds: 300)));
          } else if (state is DrinkAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Drink Added Successfully!"),
                duration: Duration(milliseconds: 300)));
            bloc.add(const GetDrinksList());
          } else if (state is DrinkAddingState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Adding Drink.."),
                duration: Duration(milliseconds: 300)));
          } else if (state is DrinkDeletingState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Deleting Drink.."),
                duration: Duration(milliseconds: 300)));
          }
        },
        child: _BuildUI(bloc: bloc));
  }
}

class _BuildUI extends StatelessWidget {
  final DrinkBloc bloc;

  const _BuildUI({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<CustomDropDownWidgetState>();
    List<Drink> drinks = const [];
    return Scaffold(
      appBar: AppBar(
          title: Text("Drinks list", style: largeWhite),
          backgroundColor: primaryColor1),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    insetPadding: EdgeInsets.all(SizeConfig().h(15)),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: radiusAll20, color: Colors.white),
                        padding: EdgeInsets.all(SizeConfig().h(15)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Add a new Drink of today"),
                            CustomDropDownWidget(
                              key: key,
                              items: const [
                                'Zero',
                                'Quarter',
                                'Half',
                                'One',
                                'One and a half',
                                'Two',
                                'Two and a half',
                                'Three'
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkResponse(
                                    onTap: () {
                                      String quantity =
                                          key.currentState!.currentValue;
                                      if (quantity != 'Zero') {
                                        Navigator.pop(context);
                                        bloc.add(AddNewDrink(Drink(
                                            date: DateTime.now(),
                                            noOfDrinks: quantity)));
                                      } else {
                                        pushToast(
                                            "you can't choose zero quantity!");
                                      }
                                    },
                                    child: Text("Ok", style: largeMediumBlue))
                              ],
                            )
                          ],
                        )));
              },
            );
          },
          child: const Icon(Icons.add)),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(SizeConfig().h(8.0)),
              child: LayoutBuilder(
                  builder: (_, constrained) => RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(const GetDrinksList());
                      },
                      child: BlocBuilder(
                          bloc: bloc,
                          builder: (context, DrinkState state) {
                            if (state is DrinksloadedState) {
                              drinks = state.drinks;
                              return ListView.separated(
                                  itemBuilder: (context, index) => DrinkWidget(
                                      index: index,
                                      drink: drinks[index],
                                      bloc: bloc,
                                      state: state),
                                  separatorBuilder: (_, __) =>
                                      const SeparaterWidget(),
                                  itemCount: drinks.length);
                            } else if (state is ErrorState) {
                              return RetryConnectErrorWidget(
                                  errorModel: state.errorModel,
                                  maxHeight: constrained.maxHeight);
                            } else if ((state is DrinkAddingState ||
                                state is DrinkDeletingState ||
                                state is DrinkDeletedState)) {
                              if (state is DrinkDeletedState) {
                                drinks.removeAt(state.index);
                              }
                              if (drinks.isNotEmpty) {
                                return ListView.separated(
                                    itemBuilder: (context, index) =>
                                        DrinkWidget(
                                            index: index,
                                            drink: drinks[index],
                                            bloc: bloc,
                                            state: state),
                                    separatorBuilder: (_, __) =>
                                        const SeparaterWidget(),
                                    itemCount: drinks.length);
                              } else {
                                return RetryConnectErrorWidget(
                                    errorModel: const ErrorModel(
                                        errorType: ErrorType.noItemsError,
                                        errorValue:
                                            "There is no drinks found!"),
                                    maxHeight: constrained.maxHeight);
                              }
                            }

                            // LoadingState
                            else {
                              return const CustomLoading();
                            }
                          }))))),
      drawer: SizedBox(
        width: SizeConfig.width / 2,
        child: Drawer(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig().h(50)),
            child: Column(
              children: [
                DrawerTapWidget(
                    onTap: () {
                      Navigator.pushNamed(context, AboutAppPage.route);
                    },
                    title: 'About the app',
                    iconData: Icons.info),
                DrawerTapWidget(
                    onTap: () {}, title: 'Log out', iconData: Icons.logout)
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class DrawerTapWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;

  const DrawerTapWidget(
      {Key? key, required this.iconData, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig().w(15), vertical: SizeConfig().h(15)),
        child: Row(
          children: [
            Icon(iconData),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(5)),
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }
}

class DrinkWidget extends StatelessWidget {
  final int index;
  final Drink drink;
  final DrinkBloc bloc;
  final DrinkState state;

  const DrinkWidget(
      {Key? key,
      required this.drink,
      required this.bloc,
      required this.state,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
        key: ObjectKey(drink.id),
        trailingActions: <SwipeAction>[
          SwipeAction(
              title: "delete",
              performsFirstActionWithFullSwipe: true,
              onTap: (CompletionHandler handler) async {
                bloc.add(DeleteDrinkEvent(drink, index));
                if (state is DrinkDeletedState) {
                  await handler(true);
                }
              },
              color: Colors.red),
        ],
        child: Container(
          decoration:
              BoxDecoration(borderRadius: radiusAll14, color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(5)),
          height: SizeConfig().h(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Number of drinks: ${drink.noOfDrinks}"),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(DateFormat('hh:mm a').format(drink.date)),
                Text(DateFormat('yyyy-MM-dd').format(drink.date))
              ])
            ],
          ),
        ));
  }
}
