

import '../../data/models/pizza_item_model.dart';

sealed class PizzaLayoutState {}
final class PizzaInitial extends PizzaLayoutState {}

final class PizzaLoaded extends PizzaLayoutState {
  final List<PizzaItemModel> pizza;

  PizzaLoaded(this.pizza);

}
