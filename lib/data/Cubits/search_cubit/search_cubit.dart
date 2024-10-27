import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  // ignore: non_constant_identifier_names
  void search_icon() {
    if (search == true) {
      search = false;
    } else {
      search = true;
    }
    emit(SearchInitial());
  }
}
