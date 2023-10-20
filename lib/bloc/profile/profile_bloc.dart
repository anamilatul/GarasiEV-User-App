import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/models/profile_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/profile_remote_datasource.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(_Initial()) {
    on<_GetProfile>((event, emit) async {
      emit(const _Loading());
      final result = await ProfileRemoteDataSource().getProfile();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
