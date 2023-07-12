
class LoginRequest{
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});


}

class RegisterRequest{
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest({required this.email, required this.password, required this.name, required this.confirmPassword});


}