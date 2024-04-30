// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:resto_fic14/data/datasources/auth_remote_datasource.dart';
import 'package:resto_fic14/data/models/response/auth_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;
  LoginBloc(
    this.authRemoteDataSource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      await Future.delayed(const Duration(seconds: 2));
      final result =
          await authRemoteDataSource.login(event.email, event.password);
      result.fold(
        (error) => emit(_Error(error)),
        (success) => emit(
          _Success(success),
        ),
      );
    });
  }
}
