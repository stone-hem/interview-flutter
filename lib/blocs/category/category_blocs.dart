import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/category/category_events.dart';
import 'package:interview/blocs/category/category_states.dart';
import 'package:interview/repository/news_categories_repository.dart';

class CategoryBloc extends Bloc<CategoryEvents,CategoryStates>{
  final CategoryRepository _categoryRepository;
  CategoryBloc(this._categoryRepository):super(CategoryLoadingState()){
    on<LoadCategoryEvent>((event, emit) async{
      emit(CategoryLoadingState());
      try{
        final category=await _categoryRepository.getCategories();
        emit(CategoryLoadedState(category));
      }catch(e){
        emit(CategoryErrorState(e.toString()));
      }
    });
  }
}