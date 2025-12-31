import 'package:cineflow/features/auth/domain/usecase/user_log_in.dart';
import 'package:cineflow/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/user.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;

  AuthBloc({required UserSignUp userSignup, required UserLogIn userLogin})
    : _userSignUp = userSignup,
      _userLogIn = userLogin,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignUp(
        SignUpParam(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<AuthLogIn>((event, emit) async {
      emit(AuthLoading());
      final response = await _userLogIn(
        LoginParam(email: event.email, password: event.password),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });
  }
}
