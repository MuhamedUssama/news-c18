import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/resources/colors_manager.dart';
import 'package:news_c18/ui/search/cubit/search_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        autocorrect: true,
        controller: searchCubit.searchController,
        cursorColor: ColorsManager.lightPrimaryColor,
        cursorRadius: Radius.circular(16),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => searchCubit.search(),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: .w500,
          color: ColorsManager.lightPrimaryColor,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: .w500,
            color: ColorsManager.lightPrimaryColor,
          ),
          prefixIcon: IconButton(
            onPressed: () => searchCubit.search(),
            icon: Icon(Icons.search),
          ),
          suffixIcon: IconButton(
            onPressed: () => searchCubit.clearSearch(),
            icon: Icon(Icons.clear_rounded),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: ColorsManager.lightPrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: ColorsManager.lightPrimaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: ColorsManager.lightPrimaryColor),
          ),
        ),
      ),
    );
  }
}
