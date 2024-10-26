import 'dart:convert';

import 'package:news_app_ahmed_othman_alhalwagy/data/Modules/get_news_model.dart';
import 'package:http/http.dart' as http;

String topic = "";
// ignore: non_constant_identifier_names
int news_index = 0;
List<GetNewsModel> news = [];
// ignore: non_constant_identifier_names
List<GetNewsModel> latest_news = [];
// ignore: non_constant_identifier_names
bool shown_news =
    false; // if flase so the shown news is the latest nes and if true so the shown news is the default news
bool search = false;
// ignore: non_constant_identifier_names
String search_text = '';
// ignore: prefer_typing_uninitialized_variables
var response;
String sort = '';
String lang = '';

class GetNewsRepo {
  Future<GetNewsModel?> getNews(topic) async {
    try {
      if (search_text != '') {
        // print('search by topic and field ali');
        // print('topic: ${topic} ali');
        // print('search_text: ${search_text} ali');
        response = await http.get(Uri.parse(
            'https://newsapi.org/v2/everything?q=$topic,$search_text&language=$lang&sortBy=$sort&apiKey=9be379fc71b74bda8253a9be24fe0ee6'));
        search_text = '';
      } else {
        // print('search by topic only ali');
        // // ignore: unnecessary_brace_in_string_interps
        // print('topic: ${topic} ali');
        // print('search_text: ${search_text} ali');
        // print('lang: ' + lang + ' ali');
        response = await http.get(Uri.parse(
            // ignore: unnecessary_brace_in_string_interps
            'https://newsapi.org/v2/everything?q=${topic}&language=$lang&sortBy=$sort&apiKey=9be379fc71b74bda8253a9be24fe0ee6'));
      }

      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print('object //**');
        GetNewsModel myResponse = GetNewsModel.fromJson(decodedResponse);
        news = [myResponse];
        // print(news[0].articles[news_index].urlToImage.toString() + '//**');
        // print('object 123456789 //**');
        news[0].articles.removeWhere((item) => item.title == '[Removed]');
        shown_news = true;
        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<GetNewsModel?> getLatestNews() async {
    try {
      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=Latest&sortby=latest&apiKey=9be379fc71b74bda8253a9be24fe0ee6'));
      // final response = await http.get(
      //   Uri.parse(
      //       'https://newsapi.org/v2/everything?q=Latest&sortby=latest&apiKey=9be379fc71b74bda8253a9be24fe0ee6'),
      // );

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print('object //**');
        GetNewsModel myResponse = GetNewsModel.fromJson(decodedResponse);
        latest_news = [myResponse];

        latest_news[0]
            .articles
            .removeWhere((item) => item.title == '[Removed]');
        // print(
        //     latest_news[0].articles[news_index].urlToImage.toString() + '//**');
        // latest_news[0]
        //     .articles
        //     .removeWhere((item) => item.title == '[Removed]');
        // for (int i = 0; i < latest_news[0].articles.length; i++) {
        //   if (latest_news[0].articles[i].title == '[Removed]') {
        //     // latest_news[0].articles.remove(latest_news[0].articles[i]);
        //     latest_news[0].articles.removeAt(i);
        //     print(i.toString() + '//**');
        //   }
        // }
        shown_news = false;
        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
