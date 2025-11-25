import 'package:bloc/bloc.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/usecase/remove_multiple_item.dart';
import 'package:catalog_product_app/features/product/domain/usecase/remove_product_from_cart.dart';
import 'package:equatable/equatable.dart';

part 'list_product_cart_screen_state.dart';

class ListProductCartScreenCubit extends Cubit<ListProductCartScreenState> {
  final GetCart _getCart;
  final GetCartSummary _getSummary;
  final RemoveProductFromCart _removeProductFromCart;
  final RemoveMultipleItem _removeMultipleItem;

  ListProductCartScreenCubit(
    this._getCart,
    this._getSummary,
    this._removeProductFromCart,
    this._removeMultipleItem,
  ) : super(ListProductCartScreenInitial()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(ListProductCartScreenInitial());
    final cartResult = await _getCart();
    final summaryResult = await _getSummary();

    cartResult.fold(
      (error) => emit(ListProductCartScreenError(errorMsg: error.message)),
      (cart) async {
        summaryResult.fold(
          (err) => emit(ListProductCartScreenError(errorMsg: err.message)),
          (data) => emit(
            ListProductCartScreenLoaded(
              cartItems: cart,
              summary: data,
              isManageMode: false,
              selectedItems: [],
            ),
          ),
        );
      },
    );
  }

  void toogleMode() {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    final newmode = state.isManageMode;
    emit(
      state.copyWith(
        isManageMode: !newmode,
        selectedItems: !newmode ? const [] : const [],
      ),
    );
  }

  void toogleItemSelection(CartItem items) {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    final selected = Set<CartItem>.from(state.selectedItems);
    if (selected.contains(items)) {
      selected.remove(items);
    } else {
      selected.add(items);
    }
    emit(state.copyWith(selectedItems: selected.toList()));
  }

  void selectAll() {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    emit(state.copyWith(selectedItems: state.selectedItems));
  }

  void unselectAll() {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    emit(state.copyWith(selectedItems: const []));
  }

  Future<void> removeSelectedItems() async {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    if (state.selectedItems.isEmpty) return;
    emit(state.copyWith(isRemoving: true));

    final dataToRemove = state.selectedItems.map((e) => e.product).toList();
    final result = await _removeMultipleItem(dataToRemove);

    result.fold(
      (error) => emit(ListProductCartScreenError(errorMsg: error.message)),
      (_) => loadCart(),
    );
  }

  Future<void> removeSingleItem(Product product) async {
    final state = this.state;
    if (state is! ListProductCartScreenLoaded) return;
    emit(state.copyWith(isRemoving: true));

    final result = await _removeProductFromCart(product);
    result.fold((error) {
      emit(state.copyWith(isRemoving: false));
      emit(ListProductCartScreenError(errorMsg: error.message));
    }, (_) => loadCart());
  }
}
