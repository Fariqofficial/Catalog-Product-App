import 'package:catalog_product_app/core/network/network_info.dart';
import 'package:catalog_product_app/features/product/data/datasource/product_remote_datasource.dart';
import 'package:catalog_product_app/features/product/data/datasource/product_remote_local_datasource.dart';
import 'package:catalog_product_app/features/product/data/repositories_impl/product_repositories_impl.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:catalog_product_app/features/product/domain/usecase/add_to_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/decrement_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_all_product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_detail_product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/remove_multiple_item.dart';
import 'package:catalog_product_app/features/product/domain/usecase/remove_product_from_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/search_product.dart';
import 'package:catalog_product_app/features/product/presentation/detail_product/cubit/detail_product_screen_cubit.dart';
import 'package:catalog_product_app/features/product/presentation/list_product/cubit/list_product_screen_cubit.dart';
import 'package:catalog_product_app/features/product/presentation/list_product_cart/cubit/list_product_cart_screen_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> initLocator() async {
  final pref = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => pref);

  di.registerFactory(
    () => ListProductScreenCubit(di(), di(), di(), di(), di(), di()),
  );
  di.registerFactory(() => ListProductCartScreenCubit(di(), di(), di(), di()));

  di.registerLazySingleton(() => GetAllProduct(di()));
  di.registerLazySingleton(() => GetDetailProduct(di()));
  di.registerLazySingleton(() => SearchProduct(di()));
  di.registerLazySingleton(() => AddToCart(di()));
  di.registerLazySingleton(() => GetCartSummary(di()));
  di.registerLazySingleton(() => DecrementCart(di()));
  di.registerLazySingleton(() => GetCart(di()));
  di.registerLazySingleton(() => RemoveProductFromCart(di()));
  di.registerLazySingleton(() => RemoveMultipleItem(di()));

  di.registerLazySingleton<ProductRepositories>(
    () => ProductRepositoriesImpl(di(), di(), di()),
  );

  di.registerLazySingleton<ProductRemoteLocalDatasource>(
    () => ProductRemoteLocalDatasourceImpl(di()),
  );
  di.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(di()),
  );

  di.registerFactory(() => DetailProductScreenCubit(di()));

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
  di.registerLazySingleton(() => Connectivity());

  di.registerLazySingleton(() => http.Client());
}
