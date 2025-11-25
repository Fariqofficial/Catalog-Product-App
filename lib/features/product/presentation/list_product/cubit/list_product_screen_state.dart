part of 'list_product_screen_cubit.dart';

sealed class ListProductScreenState extends Equatable {
  const ListProductScreenState();

  @override
  List<Object?> get props => [];
}

final class ListProductScreenInitial extends ListProductScreenState {}

final class ListProductScreenLoadingInitial extends ListProductScreenState {}

final class ListProductScreenLoadingMore extends ListProductScreenState {}

final class ListProductScreenError extends ListProductScreenState {
  final String errorMessage;
  final int? pageKey;
  const ListProductScreenError({required this.errorMessage, this.pageKey});
  @override
  List<Object?> get props => [errorMessage, pageKey ?? 0];
}

final class ListProductScreenLoading extends ListProductScreenState {}

final class ListProductScreenSuccess extends ListProductScreenState {
  final List<Product> data;
  final int pageKey;
  final bool hasMore;
  final bool isSearch;
  final String? searchQuery;
  const ListProductScreenSuccess({
    required this.data,
    required this.pageKey,
    required this.hasMore,
    this.isSearch = false,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [data, pageKey, hasMore, isSearch, searchQuery];
}

final class ListProductScreenCartAdding extends ListProductScreenState {}

final class ListProductScreenCartSuccess extends ListProductScreenState {
  final int totalItems;
  final double totalPrice;
  const ListProductScreenCartSuccess({
    required this.totalItems,
    required this.totalPrice,
  });
  @override
  List<Object?> get props => [totalItems, totalPrice];
}

final class ListProductScreenCartError extends ListProductScreenState {
  final String errorMessage;
  const ListProductScreenCartError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
