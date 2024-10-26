part of 'get_latest_news_cubit.dart';

@immutable
sealed class GetLatestNewsState {}

final class GetLatestNewsInitial extends GetLatestNewsState {}

final class GetLatestNewsLoading extends GetLatestNewsState {}

final class GetLatestNewsSuccess extends GetLatestNewsState {
  final GetNewsModel response;
  GetLatestNewsSuccess({required this.response});
}

final class GetLatestNewsError extends GetLatestNewsState {}
