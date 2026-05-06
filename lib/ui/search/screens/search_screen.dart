import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/resources/colors_manager.dart';
import 'package:news_c18/ui/search/cubit/search_cubit.dart';
import 'package:news_c18/ui/search/cubit/search_states.dart';
import 'package:news_c18/ui/search/widgets/build_success_state_view.dart';
import 'package:news_c18/ui/search/widgets/search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchTextField(),
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {
                switch (state) {
                  case SearchInitialState():
                    return _buildInitailsState();
                  case SearchLoadingState():
                    return _buildLoadingState();
                  case SearchSuccessState():
                    return BuildSuccessStateView(articles: state.articles);
                  case SearchFailureState():
                    return _buildFailedState(state.errorMessage);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInitailsState() {
  return Expanded(
    child: Center(
      child: Text(
        'Search for news',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorsManager.lightPrimaryColor,
        ),
      ),
    ),
  );
}

Widget _buildLoadingState() {
  return Expanded(
    child: Center(
      child: CircularProgressIndicator(color: ColorsManager.lightPrimaryColor),
    ),
  );
}

Widget _buildFailedState(String errorMessage) {
  return Expanded(
    child: Center(
      child: Text(
        errorMessage,
        style: TextStyle(
          fontSize: 16,
          fontWeight: .w500,
          color: ColorsManager.lightPrimaryColor,
        ),
      ),
    ),
  );
}
