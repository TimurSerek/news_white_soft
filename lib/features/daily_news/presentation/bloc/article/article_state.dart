import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';

abstract class ArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const ArticleState({this.articles, this.error});

  @override
  List<Object> get props => [articles!, error!];
}

class ArticlesLoadingState extends ArticleState{
  const ArticlesLoadingState();
}

class ArticlesDoneState extends ArticleState{
  const ArticlesDoneState(List<ArticleEntity> articles) : super(articles: articles);
}

class ArticlesErrorState extends ArticleState{
  const ArticlesErrorState(DioException error) : super(error: error);
}