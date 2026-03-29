class Validation {
  static String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 10) {
      return 'Phone number must contain 10 digits.';
    }
    return null;
  }

  static String? validateUsername(String username) {
    if (username.length <= 3) {
      return 'Username must contain more than 3 characters.';
    }
    if (!RegExp(r'[a-z]').hasMatch(username)) {
      return 'Password must contain at least one lowercase letter.';
    }
    return null;
  }

  static String? validatePassword(String password,) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if ( password.length > 25) {
      return 'Password must be less than 25 characters.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number.';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return 'Password must contain at least one special character (! @ # \$ & * ~).';
    }

    return null;
  }
  static String? validatePasswordMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Password and Confirm Password do not match.';
    }
    if (password.length < 8 ) {
      return 'Password must be at least 8 characters long.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number.';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return 'Password must contain at least one special character (! @ # \$ & * ~).';
    }

    return null;
  }

  static String? validateEmail(String email) {
    const pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (email.isEmpty) {
      return "Please Enter The Email";
    } else if (!regex.hasMatch(email)) {
      return "Please Enter A Valid Email";
    }
    return null;
  }
  static String? validateTermsAccepted(bool isAccepted) {
    if (!isAccepted) {
      return 'Please accept the terms and conditions.';
    }
    return null;
  }
}
