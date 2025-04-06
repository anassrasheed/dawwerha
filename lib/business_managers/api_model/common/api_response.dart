import 'dart:typed_data';

class ApiResponse {
  Uint8List? body;
  String? stringBody;
  Map<String, List<String>>? headers;
  int? statusCode;

  ApiResponse();

  ApiResponse.fromApiResponse(
      this.body, this.headers, this.statusCode, this.stringBody);

  ApiResponse.clone(ApiResponse response)
      : this.fromApiResponse(response.body, response.headers,
            response.statusCode, response.stringBody);
}
