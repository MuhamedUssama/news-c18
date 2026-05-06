import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/ui/home/screen/home_screen.dart';
import 'package:news_c18/ui/search/cubit/search_cubit.dart';
import 'package:news_c18/ui/search/screens/search_screen.dart';

abstract final class RoutesManager {
  static const String homeRouteName = "home";
  static const String searchRouteName = "search";

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRouteName: (_) => const HomeScreen(),
    searchRouteName: (_) =>
        BlocProvider(create: (_) => SearchCubit(), child: const SearchScreen()),
  };
}
