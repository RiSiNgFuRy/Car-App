class AppExceptions implements Exception{
  final String? _message;
  final String? _prefix;

  AppExceptions(this._prefix, this._message);

  @override
  String toString() => "$_prefix : $_message";
}

class FetchDataException extends AppExceptions {

  FetchDataException([String? message]) : super("Error During Fetching Data", message);
}

class BadRequestException extends AppExceptions {

  BadRequestException([String? message]) : super("Invalid Request", message);
}

class DataNotFoundException extends AppExceptions {

  DataNotFoundException([String? message]) : super("Data Not Found", message);
}

class UnauthorizedRequestException extends AppExceptions {

  UnauthorizedRequestException([String? message]) : super("Unauthorized Request", message);
}

class InvalidInputException extends AppExceptions {

  InvalidInputException([String? message]) : super("Invalid Input", message);
}