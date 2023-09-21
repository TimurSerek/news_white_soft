import 'package:news_white_soft/core/constants/constants.dart';
import 'package:news_white_soft/core/resources/data_state.dart';
import 'package:news_white_soft/features/daily_news/data/data_sources/news_api_service.dart';
import 'package:news_white_soft/features/daily_news/data/models/article.dart';
import 'package:news_white_soft/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    final response = await _newsApiService.getNewsArticles(
      apiKey: newsAPIKey,
      country: countryQuery,
      category: categoryQuery,
    );

    return response;
  }
}
