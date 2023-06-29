RegExp EMAIL_REGEX = RegExp(
    r"/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/");
RegExp NAME_REGEX = RegExp("^[a-zA-Z]+( [a-zA-Z]+)*\$");
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) return "Email is required!";
  if (EMAIL_REGEX.hasMatch(email))
    return "Provided email is not a valid email!";
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) return "Password is required!";
  if (password.length < 8)
    return "Password must consist of at least 8 characters!";
  return null;
}

String? validateName(String? name) {
  if (name == null || name.isEmpty) return "Name is required!";
  if (name.length < 5) return "Name must consist of at least 5 characters!";
  if (!NAME_REGEX.hasMatch(name))
    return "Name can only consist of alphabets and one space between words.";
  return null;
}

String? Function(dynamic) isNotEmpty(String message) {
  return (dynamic value) {
    if (value is String) {
      return value.isEmpty ? message : null;
    } else {
      return value == null ? message : null;
    }
  };
}

String? noValidate(dynamic any) {
  return null;
}
