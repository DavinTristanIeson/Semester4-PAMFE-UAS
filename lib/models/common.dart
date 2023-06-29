import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Identifiable {
  late final String _id;
  get id => _id;
  Identifiable() {
    _id = uuid.v4();
  }
}

enum OperationStatus {
  Ok,
  Err,
}

enum QueryStatus { Ok, NotFound }

class Result<Status, Data> {
  final Status status;
  final Data data;
  const Result(this.status, this.data);
}
