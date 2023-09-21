import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';
import 'package:provider/provider.dart';

class LatestArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final void Function(ArticleEntity article)? onArticlePressed;

  const LatestArticleWidget({
    Key? key,
    this.article,
    this.onArticlePressed,
  }) : super(key: key);

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
      child: Container(
        padding:
            const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 10),
        height: MediaQuery.of(context).size.height / 8,
        child: Provider(
          create: (_) => article,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 0, // No spread
                  blurRadius: 10, // Blur radius
                  offset: const Offset(5, 0), // Offset to the right
                ),
              ],
            ),
            child: const Row(
              children: [
                _ImageWidget(),
                _TitleAndTimeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleEntity>();
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
      child: CachedNetworkImage(
          imageUrl: article.urlToImage ?? '',
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 90,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 90,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 90,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const Icon(Icons.error),
            ),
          )),
    );
  }
}

class _TitleAndTimeWidget extends StatelessWidget {
  const _TitleAndTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleEntity>();
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Text(
            article.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          // Datetime
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                article.publishedAt ?? '',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
