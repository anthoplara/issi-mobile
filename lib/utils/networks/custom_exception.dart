class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message = ""]) : super(message: message, prefix: "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message: message, prefix: "Kesalahan request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message: message, prefix: "Tidak ada akses: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message = ""]) : super(message: message, prefix: "Kesalahan masukkan: ");
}
