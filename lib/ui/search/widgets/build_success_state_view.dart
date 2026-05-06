import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/resources/colors_manager.dart';
import 'package:news_c18/model/articles_response/Article.dart';
import 'package:news_c18/ui/artices/widgets/article_item.dart';
import 'package:news_c18/ui/search/cubit/search_cubit.dart';

class BuildSuccessStateView extends StatelessWidget {
  final List<Article> articles;
  const BuildSuccessStateView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        controller: context.read<SearchCubit>().scrollController,
        itemBuilder: (context, index) {
          if (index < articles.length) {
            return ArticleItem(article: articles[index]);
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.lightPrimaryColor,
                ),
              ),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: articles.length + 1,
      ),
    );
  }
}
