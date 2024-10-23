class RegisterState {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String rePassword;

  RegisterState(
      {this.firstName = "",
      this.lastName = "",
      this.username = "",
      this.email = "",
      this.phone = "",
      this.password = "",
      this.rePassword = ""});

  RegisterState copyWith(
      {String? firstName,
      String? lastName,
      String? username,
      String? email,
        String? phone,
      String? password,
      String? rePassword}) {
    return RegisterState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }
}
