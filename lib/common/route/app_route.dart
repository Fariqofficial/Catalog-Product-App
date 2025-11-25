import 'package:catalog_product_app/features/product/presentation/detail_product/cubit/detail_product_screen_cubit.dart';
import 'package:catalog_product_app/features/product/presentation/detail_product/detail_product_screen.dart';
import 'package:catalog_product_app/features/product/presentation/list_product/list_products_screen.dart';
import 'package:catalog_product_app/features/product/presentation/list_product_cart/cubit/list_product_cart_screen_cubit.dart';
import 'package:catalog_product_app/features/product/presentation/list_product_cart/list_product_cart_screen.dart';
import 'package:catalog_product_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static const dashboard = '/';
  static const detailProduct = '/products/detail';
  static const cartProduct = '/products/cart';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(
          builder: (context) => const ListProductsScreen(),
        );
      case detailProduct:
        final int id = settings.arguments as int? ?? 0;
        if (id == 0) return _notFoundPage;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => di<DetailProductScreenCubit>(),
            child: DetailProductScreen(id: id),
          ),
        );
      case cartProduct:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => di<ListProductCartScreenCubit>(),
            child: const ListProductCartScreen(),
          ),
        );
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
    builder: (context) => Scaffold(body: Center(child: Text("Page Not Found"))),
  );
}
