import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/remote/network/api_manager.dart';
import 'package:news_c18/ui/search/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  final TextEditingController searchController = TextEditingController();

  Future<void> search() async {
    final String query = searchController.text.trim();

    if (query.isEmpty) return;

    emit(SearchLoadingState());

    try {
      final response = await ApiManager.search(query);
      if (response.status != "error") {
        emit(SearchSuccessState(response.articles ?? []));
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
    return super.close();
  }
}
