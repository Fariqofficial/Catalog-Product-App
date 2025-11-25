part of 'detail_product_screen_cubit.dart';

sealed class DetailProductScreenState extends Equatable {
  const DetailProductScreenState();

  @override
  List<Object> get props => [];
}

final class DetailProductScreenInitial extends DetailProductScreenState {}

final class DetailProductScreenError extends DetailProductScreenState {
  final String errorMsg;
  const DetailProductScreenError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class DetailProductScreenSuccess extends DetailProductScreenState {
  final Product data;
  const DetailProductScreenSuccess({required this.data});
  @override
  List<Object> get props => [data];
}
