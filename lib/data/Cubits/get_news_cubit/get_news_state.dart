part of 'get_news_cubit.dart';

@immutable
sealed class GetNewsState {}

final class GetNewsInitial extends GetNewsState {}

final class GetNewsLodding extends GetNewsState {}

final class GetNewsSuccess extends GetNewsState {
  final GetNewsModel response;
  GetNewsSuccess({required this.response});
}

final class GetNewsError extends GetNewsState {}

final class GetBtnUpdate extends GetNewsState {}
