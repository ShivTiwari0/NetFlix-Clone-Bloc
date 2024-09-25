import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quadb/core/api.dart';
import 'package:quadb/data/model/movie_model.dart';

class MovieRepository{
  final _api= Api();

  Future<List<MovieModel>> fetchAllMovies()async{
    try {log("repo1");
      Response response = await _api.sendRequest.get('https://api.tvmaze.com/search/shows?q=all');

    
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      
      if (!apiResponse.success) {
         throw apiResponse.message.toString();
      
      }
        return (apiResponse.data as List<dynamic>).map((json) {
        log(json.toString());
          return
           MovieModel.fromJson(json);}).toList();
            
    } catch (e) {
      rethrow;
    }
  }

   Future<List<MovieModel>> searchMovies(String query)async{
    try {
      Response response = await _api.sendRequest.get('https://api.tvmaze.com/search/shows?q=$query');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
          }

          return (apiResponse.data as List<dynamic>).map((json) {
        log(json.toString());
          return
           MovieModel.fromJson(json);}).toList();
            
    } catch (e) {
      rethrow;
    }
  }
}