import 'package:news_c18/model/articles_response/Article.dart';

sealed class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<Article> articles;
  SearchSuccessState(this.articles);
}

class SearchFailureState extends SearchStates {
  final String errorMessage;
  SearchFailureState(this.errorMessage);
}
