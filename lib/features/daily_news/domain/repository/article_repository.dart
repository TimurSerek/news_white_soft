import 'package:news_white_soft/core/resources/data_state.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository{

  //API methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}