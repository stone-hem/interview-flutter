import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/tab_news/tab_news_events.dart';
import 'package:interview/blocs/tab_news/tab_news_states.dart';
import 'package:interview/repository/tab_news_categories_repository.dart';

class TabNewsBloc extends Bloc<TabNewsEvents,TabNewsStates>{

  final TabNewsRepository _tabNewsRepository;
  TabNewsBloc(this._tabNewsRepository):super(TabNewsLoadingState()){
    on<LoadTabNewsEvent>((event, emit) async{
      emit(TabNewsLoadingState());
      try{
        final tabNews=await _tabNewsRepository.getTabNews();
        emit(TabNewsLoadedState(tabNews));
      }catch(e){
        emit(TabNewsErrorState(e.toString()));
      }
    });
  }
}