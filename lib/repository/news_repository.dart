import 'dart:convert';

import 'package:http/http.dart';
import 'package:interview/models/NewsModel.dart';

class NewsRepository{
  String uri="http://192.168.88.236:8000/api/recent";
  Future<List<NewsModel>> getRecentNews() async{
    Response response=await get(Uri.parse(uri));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => NewsModel.fromJson(e)).toList();

    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}