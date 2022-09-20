import 'package:dio/dio.dart';
import 'package:nike/common/exceptions.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      return response;
    }
  }
}
