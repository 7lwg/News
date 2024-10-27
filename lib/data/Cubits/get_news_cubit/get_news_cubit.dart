import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Modules/get_news_model.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';

part 'get_news_state.dart';

class GetNewsCubit extends Cubit<GetNewsState> {
  GetNewsCubit() : super(GetNewsInitial());
  GetNewsRepo newsRepo = GetNewsRepo();

  getNews(topic) async {
    emit(GetNewsLodding());

    try {
      await newsRepo.getNews(topic).then((value) {
        if (value != null) {
          emit(GetNewsSuccess(response: value));
        } else {
          emit(GetNewsError());
        }
      });
    } catch (error) {
      emit(GetNewsError());
    }
  }

  // ignore: non_constant_identifier_names
  void btn_update() {
    emit(GetBtnUpdate());
  }
}
