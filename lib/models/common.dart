class Result<Status, Data> {
  final Status status;
  final Data data;
  const Result(this.status, this.data);
}

class UserException implements Exception {
  String message;
  UserException(this.message);
}
