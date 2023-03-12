import 'package:dio/dio.dart';

mixin HeaderProvider {
  Future<Options> getHeaders() async {
    final option = Options(headers: <String, String>{
      'Content-Type': getContentType(),
    });

    return option;
  }

  String getContentType({String? versionNo}) {
    return "application/json";
  }
}
