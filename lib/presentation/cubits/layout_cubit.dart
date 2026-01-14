
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzashop/presentation/cubits/layout_state.dart';

import '../../../data/repos/pizza_repo.dart';

class PizzaLayoutCubit extends Cubit<PizzaLayoutState> {
  PizzaLayoutCubit(this.pizzaRepo,) : super(PizzaInitial());
  final PizzaRepo pizzaRepo;
  void loadPizza() async {

      final pizza =
      await pizzaRepo.pizzaDataSource.getPizza();
      emit(PizzaLoaded(pizza));

  }

}

