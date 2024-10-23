import 'package:courses_app/features/sign_in/provider/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState());

  void onUsernameChange(String username) {
    state = state.copyWith(username: username);
  }

  void onPasswordChange(String password) {
    state = state.copyWith(password: password);
  }
}

final signInNotifierProvider = StateNotifierProvider<SignInNotifier, SignInState>((ref) => SignInNotifier());
