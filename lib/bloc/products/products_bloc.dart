import 'package:bloc/bloc.dart';
import 'package:flutter_multistore_user_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_multistore_user_app/data/models/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final result = await ProductRemoteDatasource().getProducts();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetByCategory>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource()
          .getProductsByCategory(event.categoryId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
