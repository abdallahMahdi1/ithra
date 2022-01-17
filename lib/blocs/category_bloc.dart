import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/cat_fetch.dart';
import 'package:ithra/modules/category_module.dart';
//Event
class CategoryEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchCategory extends CategoryEvent{}
//State
class CategoryState extends Equatable{
  @override
  List<Object> get props =>  [];

}

class AppIsClosed2 extends CategoryState{}

class CategoryIsLoading extends CategoryState{}

class CategorySuccessful extends CategoryState{
  final Cat result;
  CategorySuccessful(this.result);
  @override
  List<Object> get props => [result];
}


class CategoryFailed extends CategoryState{}
//Bloc

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  CategoryBloc(CategoryState initialState) : super(initialState);

  CategoryState get initialState => AppIsClosed2();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async*{
    if(event is FetchCategory){
      yield CategoryIsLoading();
      try{
        Cat result = await fetchCata();
        yield (CategorySuccessful(result));
      }
      catch(e){
        yield CategoryFailed();
      }


    }

  }


}