import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/cart_repository.dart';

import '../../../common/exceptions.dart';
import '../../../data/repo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final AuthRepository authRepository;
  AuthBloc(this.authRepository, {this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonIsClicked) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
            await authRepository.login(event.userName, event.password);
            await cartRepository.count();
            emit(AuthSuccess(isLoginMode));
          } else {
            await authRepository.signUp(event.userName, event.password);
            emit(AuthSuccess(isLoginMode));
          }
        } else if (event is AuthModeChanfeIsClicked) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (e) {
        emit(AuthError(isLoginMode, AppException()));
      }
    });
  }
}
