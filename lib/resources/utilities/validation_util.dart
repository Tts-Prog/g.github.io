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

  static String? validateFullName(String input) {
    if (input.isEmpty) {
      return "Name is required";
    }

    // Regular expression to match two words starting with capital letters separated by a space
    RegExp regex = RegExp(r"^[A-Z][a-z]*\s[A-Z][a-z]*$");

    if (!regex.hasMatch(input)) {
      return "Must contain first and last names starting with\ncapital letters separated by a space";
    }

    return null;
  }

  static String? validatePassword(String input) {
    if (input.isEmpty) {
      return "Password is required";
    }

    if (input.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null;
  }

  static String? validateConfirmPasword(
      String confirmPassword, String password) {
    if (confirmPassword != password) {
      return "Please make sure your Passwords match";
    }
    return null;
  }
}
