import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_white_soft/config/theme/text_styles.dart';
import 'package:news_white_soft/core/constants/strings.dart';
import 'package:news_white_soft/core/injection_container.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';
import 'package:news_white_soft/features/daily_news/presentation/bloc/article/article_bloc.dart';
import 'package:news_white_soft/features/daily_news/presentation/bloc/article/article_event.dart';
import 'package:news_white_soft/features/daily_news/presentation/bloc/article/article_state.dart';
import 'package:news_white_soft/features/daily_news/presentation/widgets/latest_article_tile.dart';
import 'package:news_white_soft/features/daily_news/presentation/widgets/featured_article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: BlocProvider<ArticlesBloc>(
        create: (context) => sl()..add(const GetArticlesEvent()),
        child: const _Body(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.notifications),
      actions: [
        TextButton(
          onPressed: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              AppStrings.markAllRead,
              style: AppTextStyles.size18RegularOpenSansBlack,
            ),
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticleState>(builder: (_, state) {
      if (state is ArticlesLoadingState) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is ArticlesErrorState) {
        return const _RefreshButton();
      }
      if (state is ArticlesDoneState) {
        return _LatestArticlesList(state: state);
      }
      return const SizedBox();
    });
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({Key? key}) : super(key: key);

  void _refreshArticleList(BuildContext context) {
    BlocProvider.of<ArticlesBloc>(context).add(const GetArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _refreshArticleList(context);
      },
      child: const Center(child: Icon(Icons.refresh)),
    );
  }
}

class _LatestArticlesList extends StatelessWidget {
  final ArticleState state;

  const _LatestArticlesList({Key? key, required this.state}) : super(key: key);

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const _ListTitle(title: AppStrings.featured),
      SliverToBoxAdapter(
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: state.articles?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Row(
                children: [
                  const SizedBox(width: 24),
                  FeaturedArticleWidget(
                    article: state.articles?[index],
                    onArticlePressed: (article) =>
                        _onArticlePressed(context, article),
                  ),
                ],
              );
            }
            return FeaturedArticleWidget(
              article: state.articles?[index],
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 24);
          },
        ),
      )),
      const _ListTitle(title: AppStrings.latestNews),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return LatestArticleWidget(
              article: state.articles?[index],
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            );
          },
          childCount: state.articles?.length,
        ),
      ),
    ]);
  }
}

class _ListTitle extends StatelessWidget {
  final String title;

  const _ListTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 24.0),
        child: Text(
          title,
          style: AppTextStyles.size20ItalicOpenSansBlack,
        ),
      ),
    );
  }
}
