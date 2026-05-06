import 'package:flutter/material.dart';
import 'package:news_c18/model/articles_response/Article.dart';
import 'package:news_c18/ui/artices/widgets/article_item.dart';

class BuildSuccessStateView extends StatelessWidget {
  final List<Article> articles;
  const BuildSuccessStateView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return ArticleItem(article: articles[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: articles.length,
      ),
    );
  }
}
