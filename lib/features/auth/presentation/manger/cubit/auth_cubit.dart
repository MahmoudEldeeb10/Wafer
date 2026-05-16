import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/auth/data/models/auth_model.dart';
import 'package:wafer/features/auth/data/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo = AuthRepo();

  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.login(
        LoginRequestModel(usernameOrEmail: usernameOrEmail, password: password),
      );

      if (response.success && response.data != null) {
        final prefs = await SharedPreferences.getInstance();
        if (response.success && response.data != null) {
          final prefs = await SharedPreferences.getInstance();
          if (response.data!.token != null) {
            await prefs.setString('token', response.data!.token!);
            await prefs.setInt('accountType', response.data!.role!);
print('Saved accountType: ${prefs.getInt('accountType')}');
          }
          emit(AuthSuccess());
        } else {
          emit(AuthError(response.message));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> register(RegisterRequestModel request) async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.register(request);
      if (response.success) {
        emit(AuthSuccess());
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

}
