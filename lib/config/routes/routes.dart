import 'package:flutter/material.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';
import 'package:news_white_soft/features/daily_news/presentation/pages/article_details/article_details.dart';
import 'package:news_white_soft/features/daily_news/presentation/pages/home/daily_news.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        return _materialRoute(ArticleDetails(article: settings.arguments as ArticleEntity));

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}