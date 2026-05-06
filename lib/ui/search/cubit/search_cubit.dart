import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/remote/network/api_manager.dart';
import 'package:news_c18/model/articles_response/Article.dart';
import 'package:news_c18/ui/search/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState()) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          log('At the bottom of screen');
          Future.delayed(const Duration(seconds: 2), () {
            search(isLoadingMore: true);
          });
        }
      }
    });
  }

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  int page = 1;
  final List<Article> allArticles = [];

  Future<void> search({bool isLoadingMore = false}) async {
    final String query = searchController.text.trim();

    if (query.isEmpty) return;
    if (isLoadingMore) {
      page++;
    } else {
      page = 1;
      allArticles.clear();
      emit(SearchLoadingState());
    }

    try {
      final response = await ApiManager.search(query, page);
      if (response.status != "error") {
        final List<Article> newArticles = response.articles ?? []; // 10
        allArticles.addAll(newArticles); // 10 + 10 = 20
        emit(SearchSuccessState(allArticles)); // 20
      } else {
        emit(SearchFailureState(response.message ?? "Something went wrong"));
      }
    } catch (exception) {
      emit(SearchFailureState(exception.toString()));
    }
  }

  void clearSearch() {
    searchController.clear();
    emit(SearchInitialState());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
