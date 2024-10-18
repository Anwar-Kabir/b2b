class FormValidator {
  // Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
  

  //conform password validation
  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  // Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  

  //url validation
  static String? validateURL(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    }
    final urlRegex = RegExp(
        r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:[0-9]{1,5})?(\/.*)?$');
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  //zipe code validation
  static String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a postal code';
    }
    final postalCodeRegex = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');
    if (!postalCodeRegex.hasMatch(value)) {
      return 'Please enter a valid postal code';
    }
    return null;
  }

  //cradit card validation
  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a credit card number';
    }
    final cardRegex = RegExp(r'^[0-9]{16}$');
    if (!cardRegex.hasMatch(value)) {
      return 'Please enter a valid 16-digit credit card number';
    }
    return null;
  }

  
}
