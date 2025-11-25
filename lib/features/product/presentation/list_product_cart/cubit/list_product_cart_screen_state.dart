part of 'list_product_cart_screen_cubit.dart';

sealed class ListProductCartScreenState extends Equatable {
  const ListProductCartScreenState();

  @override
  List<Object> get props => [];
}

final class ListProductCartScreenInitial extends ListProductCartScreenState {}

final class ListProductCartScreenLoaded extends ListProductCartScreenState {
  final List<CartItem> cartItems;
  final CartSummary summary;
  final bool isManageMode;
  final List<CartItem> selectedItems;
  final bool isRemoving;

  const ListProductCartScreenLoaded({
    required this.cartItems,
    required this.summary,
    required this.isManageMode,
    required this.selectedItems,
    this.isRemoving = false,
  });

  ListProductCartScreenLoaded copyWith({
    List<CartItem>? cartItems,
    CartSummary? summary,
    bool? isManageMode,
    List<CartItem>? selectedItems,
    bool? isRemoving,
  }) {
    return ListProductCartScreenLoaded(
      cartItems: cartItems ?? this.cartItems,
      summary: summary ?? this.summary,
      isManageMode: isManageMode ?? this.isManageMode,
      selectedItems: selectedItems ?? this.selectedItems,
      isRemoving: isRemoving ?? this.isRemoving,
    );
  }

  bool get canEnterManageMode => cartItems.length > 1;

  bool get isAllSelected =>
      selectedItems.length == cartItems.length && cartItems.isNotEmpty;

  @override
  List<Object> get props => [
    cartItems,
    summary,
    isManageMode,
    selectedItems,
    isRemoving,
  ];
}

final class ListProductCartScreenError extends ListProductCartScreenState {
  final String errorMsg;
  const ListProductCartScreenError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
