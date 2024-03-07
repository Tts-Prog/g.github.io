class ValidationUtil {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email address is required";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "email address is not valid";
    }

    return null;
  }
}
