class GlobalFunction {
  bool isPasswordValid(String password) {
    // Check password length
    if (password.length < 8) {
      return false;
    }

    // Check for at least one uppercase letter
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));

    // Check for at least one lowercase letter
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    // Check for at least one digit
    bool hasDigit = password.contains(RegExp(r'[0-9]'));

    // Check for at least one special character
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Ensure all criteria are met
    return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}
