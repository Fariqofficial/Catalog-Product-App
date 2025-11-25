import 'package:bloc/bloc.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/add_to_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/decrement_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_all_product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/usecase/search_product.dart';
import 'package:equatable/equatable.dart';
part 'list_product_screen_state.dart';

class ListProductScreenCubit extends Cubit<ListProductScreenState> {
  final GetAllProduct _getAllProduct;
  final SearchProduct _searchProduct;
  final AddToCart _addToCart;
  final GetCartSummary _getCartSummary;
  final DecrementCart _decrementCart;
  final GetCart _getCart;

  ListProductScreenCubit(
    this._getAllProduct,
    this._searchProduct,
    this._addToCart,
    this._getCartSummary,
    this._decrementCart,
    this._getCart,
  ) : super(ListProductScreenInitial());

  Map<int, int> _quantities = {};
  final int _pageSize = 5;

  void fetchPage(int pageKey) async {
    if (state is ListProductScreenLoadingInitial ||
        state is ListProductScreenLoadingMore) {
      return;
    }

    if (pageKey == 1) {
      emit(ListProductScreenLoadingInitial());
    } else {
      emit(ListProductScreenLoadingMore());
    }

    final result = await _getAllProduct.call(pageKey, _pageSize);

    result.fold(
      (error) => emit(
        ListProductScreenError(errorMessage: error.message, pageKey: pageKey),
      ),
      (data) => emit(
        ListProductScreenSuccess(
          data: data,
          pageKey: pageKey,
          hasMore: data.length == _pageSize,
          isSearch: false,
          searchQuery: null,
        ),
      ),
    );
  }

  void searchPage(String query, int pageKey) async {
    if (state is ListProductScreenLoadingInitial ||
        state is ListProductScreenLoadingMore) {
      return;
    }

    if (pageKey == 1) {
      emit(ListProductScreenLoadingInitial());
    } else {
      emit(ListProductScreenLoadingMore());
    }

    final result = await _searchProduct.call(query);

    result.fold(
      (error) => emit(
        ListProductScreenError(errorMessage: error.message, pageKey: pageKey),
      ),
      (fullData) {
        final start = (pageKey - 1) * _pageSize;
        List<Product> slicedData;
        if (start >= fullData.length) {
          slicedData = [];
        } else {
          final end = start + _pageSize;
          final actualEnd = end > fullData.length ? fullData.length : end;
          slicedData = fullData.sublist(start, actualEnd);
        }
        final hasMore =
            slicedData.length == _pageSize &&
            fullData.length > start + _pageSize;

        emit(
          ListProductScreenSuccess(
            data: slicedData,
            pageKey: pageKey,
            hasMore: hasMore,
            isSearch: true,
            searchQuery: query,
          ),
        );
      },
    );
  }

  void cancelSearch() {
    emit(ListProductScreenInitial());
  }

  void addToCart(Product product) async {
    emit(ListProductScreenCartAdding());
    final result = await _addToCart.call(product);
    result.fold(
      (error) => emit(ListProductScreenCartError(errorMessage: error.message)),
      (_) async {
        final cartResult = await _getCart.call();
        cartResult.fold(
          (errorMsg) =>
              emit(ListProductScreenCartError(errorMessage: errorMsg.message)),
          (cart) {
            _quantities = {
              for (var item in cart) item.product.id: item.quantity,
            };
          },
        );

        final summaryRsult = await _getCartSummary.call();
        summaryRsult.fold(
          (errorMsg) =>
              emit(ListProductScreenCartError(errorMessage: errorMsg.message)),
          (data) => emit(
            ListProductScreenCartSuccess(
              totalItems: data.totalItems,
              totalPrice: data.totalPrice,
            ),
          ),
        );
      },
    );
  }

  Future<void> loadQuantities() async {
    final cartResult = await _getCart.call();
    cartResult.fold(
      (errorMsg) =>
          emit(ListProductScreenCartError(errorMessage: errorMsg.message)),
      (cart) {
        _quantities = {for (var item in cart) item.product.id: item.quantity};
      },
    );
    final summaryResult = await _getCartSummary.call();
    summaryResult.fold(
      (failure) =>
          emit(ListProductScreenCartError(errorMessage: failure.message)),
      (summary) => emit(
        ListProductScreenCartSuccess(
          totalItems: summary.totalItems,
          totalPrice: summary.totalPrice,
        ),
      ),
    );
  }

  void decrementCart(Product product) async {
    emit(ListProductScreenCartAdding());
    final result = await _decrementCart.call(product);
    result.fold(
      (error) => emit(ListProductScreenCartError(errorMessage: error.message)),
      (_) async {
        final cartResult = await _getCart.call();
        cartResult.fold(
          (error) =>
              emit(ListProductScreenCartError(errorMessage: error.message)),
          (cart) {
            _quantities = {
              for (var item in cart) item.product.id: item.quantity,
            };
          },
        );

        final summaryRsult = await _getCartSummary.call();
        summaryRsult.fold(
          (errorMsg) =>
              emit(ListProductScreenCartError(errorMessage: errorMsg.message)),
          (data) => emit(
            ListProductScreenCartSuccess(
              totalItems: data.totalItems,
              totalPrice: data.totalPrice,
            ),
          ),
        );
      },
    );
  }

  int getQuantity(int productId) => _quantities[productId] ?? 0;
}
