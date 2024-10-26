// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Modules/get_news_model.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';

part 'get_latest_news_state.dart';

class GetLatestNewsCubit extends Cubit<GetLatestNewsState> {
  GetLatestNewsCubit() : super(GetLatestNewsInitial());
  GetNewsRepo newsLatestRepo = GetNewsRepo();

  getLatestNews() async {
    // print('latest News1');
    emit(GetLatestNewsLoading());

    try {
      await newsLatestRepo.getLatestNews().then((value) {
        if (value != null) {
          emit(GetLatestNewsSuccess(response: value));
        } else {
          emit(GetLatestNewsError());
        }
      });
    } catch (error) {
      emit(GetLatestNewsError());
    }
  }
}
