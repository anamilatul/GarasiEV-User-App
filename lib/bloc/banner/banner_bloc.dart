import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/banner_remote_datasource.dart';
import 'package:flutter_garasi_ev/data/models/banner_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_event.dart';
part 'banner_state.dart';
part 'banner_bloc.freezed.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(const _Initial()) {
    on<_GetAllBanner>((event, emit) async {
      emit(const _Loading());
      final result = await BannerRemoteDataSource().getBanner();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
