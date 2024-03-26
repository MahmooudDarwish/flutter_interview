import 'package:uuid/uuid.dart';

abstract class UtilFunction {
  static String? validateField(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }

  static String generateId() {
    var uuid = const Uuid();
    var id = uuid.v4();
    return id;
  }
}

