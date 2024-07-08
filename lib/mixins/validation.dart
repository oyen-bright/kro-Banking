mixin ValidationMixin {
  String? _isRequired(String? value) {
    return requiredValidation(value);
  }

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  String? requiredValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "required";
    }

    return null;
  }

  String? emailValidation(String? value) {
    if (_isRequired(value) != null) {
      return _isRequired(value);
    }

    if (!_emailRegExp.hasMatch(value!)) {
      return 'invalid email address please check input';
    }

    return null;
  }
}
