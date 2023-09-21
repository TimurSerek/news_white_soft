import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_white_soft/core/resources/data_state.dart';
import 'package:news_white_soft/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent,ArticleState> {

  final GetArticleUseCase _getArticleUseCase;

  ArticlesBloc(this._getArticleUseCase) : super(const ArticlesLoadingState()){
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(GetArticlesEvent event, Emitter <ArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data != null && dataState.data!.isNotEmpty) {
      emit(ArticlesDoneState(dataState.data!));
    }

    if (dataState is DataFailed && dataState.error != null) {
      emit(ArticlesErrorState(dataState.error!));
    }
  }
}