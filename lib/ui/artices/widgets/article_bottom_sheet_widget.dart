import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c18/core/resources/colors_manager.dart';
import 'package:news_c18/model/articles_response/Article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBottomSheetWidget extends StatelessWidget {
  final Article article;
  const ArticleBottomSheetWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsManager.lightPrimaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            spacing: 8,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                article.description ?? "",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsManager.lightSecondaryColor,
                  fontWeight: .w500,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(article.url ?? "");
                  await launchUrl(url, mode: LaunchMode.inAppBrowserView);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.lightSecondaryColor,
                  foregroundColor: ColorsManager.lightPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size.fromHeight(56),
                ),
                child: Text(
                  "View Full Article",
                  style: TextStyle(fontSize: 16, fontWeight: .bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
