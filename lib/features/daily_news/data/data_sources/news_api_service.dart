import 'package:dio/dio.dart';
import 'package:news_white_soft/core/constants/constants.dart';
import 'package:news_white_soft/core/resources/data_state.dart';
import 'package:news_white_soft/features/daily_news/data/models/article.dart';

class NewsApiService {
  Future<DataState<List<ArticleModel>>> getNewsArticles({
    required String apiKey,
    required String country,
    required String category,
}) async {
    String url =
        '$newsAPIBaseURL$newsAPIPath?country=$country&apiKey=$apiKey&category=$category';
    Dio dio = Dio();

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<ArticleModel> articles = [];
        response.data['articles'].forEach((e) {
          articles.add(ArticleModel.fromJson(e));
        });
        return DataSuccess(articles);
      } else {
        return DataFailed(DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
