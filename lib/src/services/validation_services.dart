String? validateEmail(String value) {
  const pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(pattern);

  return value.isEmpty
      ? 'Email field is required.'
      : !regex.hasMatch(value)
          ? 'Enter a valid email address.'
          : null;
}
