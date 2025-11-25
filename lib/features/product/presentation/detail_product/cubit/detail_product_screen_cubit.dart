import 'package:bloc/bloc.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/usecase/get_detail_product.dart';
import 'package:equatable/equatable.dart';

part 'detail_product_screen_state.dart';

class DetailProductScreenCubit extends Cubit<DetailProductScreenState> {
  final GetDetailProduct _getDetailProduct;
  DetailProductScreenCubit(this._getDetailProduct)
    : super(DetailProductScreenInitial());

  void getDetail(int id) async {
    emit(DetailProductScreenInitial());
    final result = await _getDetailProduct.call(id);
    result.fold(
      (error) => emit(DetailProductScreenError(errorMsg: error.message)),
      (data) => emit(DetailProductScreenSuccess(data: data)),
    );
  }
}
