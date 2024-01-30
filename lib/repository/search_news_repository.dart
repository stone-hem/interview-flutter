import 'dart:convert';

import 'package:http/http.dart';
import 'package:interview/common/constants.dart';
import 'package:interview/models/NewsModel.dart';
import 'package:interview/models/TabNewsModel.dart';

class SearchNewsRepository{
  Future<List<TabNewsModel>> doSearch(String search) async{
    String uri="$baseUrl/search/$search";
    Response response=await get(Uri.parse(uri));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => TabNewsModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}