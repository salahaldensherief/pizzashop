import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzashop/data/models/cart_model.dart';
import 'package:pizzashop/data/models/pizza_item_model.dart';
import 'package:pizzashop/data/repos/pizza_repo.dart';
import 'package:pizzashop/data/source/local/pizza_data_source.dart';
import 'package:pizzashop/presentation/cubits/cart_cubit.dart';
import 'package:pizzashop/presentation/cubits/layout_cubit.dart';
import 'package:pizzashop/presentation/layout_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          PizzaLayoutCubit(PizzaRepo(PizzaDataSource()))..loadPizza(),
        ),

        BlocProvider(
          create: (context) => CartCubit(
            cart: CartModel(items: []),
            pizza: PizzaItemModel(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home:  Layout(),
      ),
    );
  }
}
