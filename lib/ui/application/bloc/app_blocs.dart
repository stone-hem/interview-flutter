import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/ui/application/bloc/app_events.dart';
import 'package:interview/ui/application/bloc/app_state.dart';

class AppBlocs extends Bloc<AppEvent,AppState>{
   AppBlocs():super(const AppState()){
     on<ChangeIndexEvent>((event, emit){
       emit(AppState(index: event.index));
     });
   }
}