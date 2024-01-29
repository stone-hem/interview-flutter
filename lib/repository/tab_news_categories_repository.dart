import 'dart:convert';

import 'package:http/http.dart';
import 'package:interview/models/NewsModel.dart';
import 'package:interview/models/TabNewsModel.dart';

class TabNewsRepository{


  late String uri;

  TabNewsRepository({required int id}) {
    uri = "http://192.168.88.236:8000/api/categories/$id";
  }


  Future<List<TabNewsModel>> getTabNews() async{
    Response response=await get(Uri.parse(uri));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => TabNewsModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}