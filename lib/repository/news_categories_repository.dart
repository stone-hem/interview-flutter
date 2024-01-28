import 'dart:convert';

import 'package:http/http.dart';
import 'package:interview/models/CategoryModel.dart';

class CategoryRepository{
  String uri="http://127.0.0.1:8000/api/categories";
  Future<List<CategoryModel>> getCategories() async{
    Response response=await get(Uri.parse(uri));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => CategoryModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}