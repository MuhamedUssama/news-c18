import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c18/model/articles_response/Article.dart';
import 'package:news_c18/model/sources_response/Source.dart';
import 'package:news_c18/ui/artices/widgets/article_item.dart';
import 'package:news_c18/ui/artices/widgets/view_model/articles_list_view_model.dart';

class ArticlesList extends StatelessWidget {
  final Source source;
  const ArticlesList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticlesListViewModel()..getArticles(source.id!),
      child: BlocBuilder<ArticlesListViewModel, ArticlesListStates>(
        builder: (context, state) {
          switch (state) {
            case ArticlesListLoadingState():
              {
                return Center(child: CircularProgressIndicator());
              }
            case ArticlesListErrorState():
              {
                return Center(child: Text(state.errorMessage));
              }
            case ArticlesListSuccessState():
              {
                List<Article> articles = state.articles;
                if (articles.isEmpty) {
                  return Center(child: Text("No articles found"));
                }
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      ArticleItem(article: articles[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: articles.length,
                );
              }
          }
        },
      ),
    )
    /*FutureBuilder(
        future: ApiManager.getArticles(source.id??""),
      builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          var response = snapshot.data;
          if(response?.status == "error"){
            return Center(child: Text(response?.message??""),);
          }
          List<Article> articles = response?.articles??[];
          if(articles.isEmpty){
            return Center(child: Text("No articles found"),);
          }
          return ListView.separated(
              itemBuilder: (context, index) => ArticleItem(article: articles[index],),
              separatorBuilder: (context, index) => SizedBox(height: 16.h,),
              itemCount: articles.length
          );
        },)*/
    ;
  }
}
