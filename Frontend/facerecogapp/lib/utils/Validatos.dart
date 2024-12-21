// ignore: file_names

class Validatos {
  String? emailvalidator(String value)  {
    final regExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value.toString().isEmpty) {
      return 'Email is required';
    }else if (regExp.firstMatch(value.toString()) != null){
      return 'Invalid email format';
    }
    return 'hi';
  }
}
