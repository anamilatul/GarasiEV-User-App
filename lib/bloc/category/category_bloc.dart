import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/category_remote_datasource.dart';
import 'package:flutter_garasi_ev/data/models/category_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const _Initial()) {
    on<_GetCategory>((event, emit) async {
      emit(const _Loading());
      final result = await CategoryRemoteDataSource().getCategory();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
