import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_white_soft/features/daily_news/data/data_sources/news_api_service.dart';
import 'package:news_white_soft/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_white_soft/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_white_soft/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'package:news_white_soft/features/daily_news/presentation/bloc/article/article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService());

  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(sl())
  );

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(
      GetArticleUseCase(sl())
  );

  //Blocs
  sl.registerFactory<ArticlesBloc>(
          ()=> ArticlesBloc(sl())
  );
}