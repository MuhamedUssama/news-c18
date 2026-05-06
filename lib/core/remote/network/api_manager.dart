import 'package:dio/dio.dart';
import 'package:news_c18/core/resources/app_constants.dart';
import 'package:news_c18/model/articles_response/Articles_response.dart';
import 'package:news_c18/model/sources_response/Sources_response.dart';

class ApiManager {
  static Dio dio = Dio(BaseOptions(baseUrl: "https://newsapi.org"));

  static Future<SourcesResponse> getSources(String selectedCategory) async {
    var response = await dio.get(
      "/v2/top-headlines/sources",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "category": selectedCategory,
      },
    );
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);
    return sourcesResponse;
  }

  static Future<ArticlesResponse> getArticles(String sourceId) async {
    //?sources=bbc-sport
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {"apiKey": AppConstants.apiKey, "sources": sourceId},
    );
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(
      response.data,
    );
    return articlesResponse;
  }

  static Future<ArticlesResponse> search(String query, int page) async {
    //?sources=bbc-sport
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {
        "apiKey": AppConstants.apiKey,
        "q": query,
        'page': page.toString(),
        'pageSize': '10',
      },
    );
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(
      response.data,
    );
    return articlesResponse;
  }
}
