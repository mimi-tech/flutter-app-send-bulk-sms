class Success{
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Success2{
  int? code;
  Map<String, dynamic>? response;
  Success2({this.code, this.response});
}

class Failure{
  int? code;
  Object? errorResponse;
  Failure({this.code, this.errorResponse});
}
