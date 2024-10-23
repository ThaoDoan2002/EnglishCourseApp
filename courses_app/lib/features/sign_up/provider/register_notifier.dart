import 'package:courses_app/features/sign_up/provider/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onFirstNameChange(String name) {
    state = state.copyWith(firstName: name);
  }

  void onLastNameChange(String name) {
    state = state.copyWith(lastName: name);
  }

  void onUsernameChange(String username) {
    state = state.copyWith(username: username);
  }


  void onUserEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPhoneChange(String phone) {
    state = state.copyWith(phone: phone);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onUserRePasswordChange(String password) {
    state = state.copyWith(rePassword: password);
  }


}
