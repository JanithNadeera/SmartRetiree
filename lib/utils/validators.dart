class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return "Provide an email address";

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return "Invalid email address";
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return "Provide a password";

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      return "Password must be at least 8 characters long and contain at least one letter and one number";
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) return "Provide a name";

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(name)) {
      return "Invalid name";
    }

    return null;
  }

  static String? validateConfrimPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm your password";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    return null;
  }

  static String? validateOccupation(String? occupation) {
    if (occupation == null || occupation.isEmpty) {
      return "Provide an occupation";
    }

    final occupationRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!occupationRegex.hasMatch(occupation)) {
      return "Invalid occupation";
    }

    return null;
  }
}
