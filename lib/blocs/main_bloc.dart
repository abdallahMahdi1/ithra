import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/main_show.dart';
import 'package:ithra/modules/Show_module.dart';
//Event
class MainShowEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchMainShow extends MainShowEvent{}
//State
class MainShowState extends Equatable{
  @override
  List<Object> get props =>  [];

}

class MainShowNotLoaded extends MainShowState{}

class MainShowIsLoading extends MainShowState{}

class MainShowSuccessful extends MainShowState{
  final Show result;
  MainShowSuccessful(this.result);
  @override
  List<Object> get props => [result];
}


class MainShowFailed extends MainShowState{}
//Bloc

class MainShowBloc extends Bloc<MainShowEvent,MainShowState>{
  MainShowBloc(MainShowState initialState) : super(initialState);

  MainShowState get initialState => MainShowNotLoaded();

  @override
  Stream<MainShowState> mapEventToState(MainShowEvent event) async*{
    if(event is FetchMainShow){
      yield MainShowIsLoading();
      try{
        Show result = await fetchMainShows();
        yield (MainShowSuccessful(result));
      }
      catch(e){
        yield MainShowFailed();
      }


    }

  }


}