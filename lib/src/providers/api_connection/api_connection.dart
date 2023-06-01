class API{
  static const hostConnect = "http://jrios-lap/go_up";
  static const hostConnectUser = "$hostConnect/app/user";

  //SignUp user
  static const validateEmail = "$hostConnectUser/signup/validate_email.php";
  static const signUp = "$hostConnectUser/signup/signup.php";

  //LogIn user
  static const validateUser = "$hostConnectUser/login/validate_user.php";
}