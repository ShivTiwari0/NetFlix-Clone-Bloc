import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String Base_Url = 'https://api.tvmaze.com/search/shows?q=all';
const Map<String, dynamic> DEAFULT_HEADERS = {
  'Content-Type': 'Application/json' 
}; 
  
class Api {
  final Dio _dio = Dio();
  Api() {
    // _dio.options.baseUrl = Base_Url;
    // _dio.options.headers = DEAFULT_HEADERS;    
    _dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestBody: true,  
        requestHeader: true,
        responseHeader: true));
  }
  Dio get sendRequest => _dio;
}
 
class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return ApiResponse(
        success: true,
        data: response.data, // Assigning response data directly
        message: "Request was successful",
      );
    } else {
      String errorMessage = "Request failed with status: ${response.statusCode}";
      if (response.data is Map<String, dynamic> && response.data.containsKey('message')) {
        errorMessage = response.data['message'];
      }
      return ApiResponse(
        success: false,
        data: null,
        message: errorMessage,
      );
    }
  }
}
