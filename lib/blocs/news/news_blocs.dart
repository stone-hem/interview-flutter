import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/news/news_events.dart';
import 'package:interview/blocs/news/news_states.dart';
import 'package:interview/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvents,NewsStates>{
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository):super(NewsLoadingState()){
    on<LoadNewsEvent>((event, emit) async{
      emit(NewsLoadingState());
      try{
        final news=await _newsRepository.getRecentNews();
        emit(NewsLoadedState(news));
      }catch(e){
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}