import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';

class FeaturedArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final void Function(ArticleEntity article)? onArticlePressed;

  const FeaturedArticleWidget({Key? key, this.article, this.onArticlePressed})
      : super(key: key);

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: CachedNetworkImage(
          imageUrl: article?.urlToImage ?? '',
          imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const CupertinoActivityIndicator(),
                ),
              ),
          errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const Icon(Icons.error),
                ),
              )),
    );
  }
}
