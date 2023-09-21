import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_white_soft/features/daily_news/domain/entities/article.dart';
import 'package:provider/provider.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleDetails({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => article,
      child: const Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          _onBackButtonTapped(context);
        },
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _ArticleImage(),
          _ArticleDescription(),
        ],
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleEntity>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: CachedNetworkImage(
          imageUrl: article.urlToImage ?? '',
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const Icon(Icons.error),
            ),
          )),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleEntity>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article.description ?? ''}\n\n${article.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
