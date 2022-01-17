import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/cat_with_epi_fetch.dart';
import 'package:ithra/modules/category_with_epi_model.dart';
//Event
class CategoryWithEpiEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchCategoryWithEpi extends CategoryWithEpiEvent{}
//State
class CategoryWithEpiState extends Equatable{
  @override
  List<Object> get props =>  [];

}

class AppIsClosed extends CategoryWithEpiState{}

class CategoryWithEpiIsLoading extends CategoryWithEpiState{}

class CategoryWithEpiSuccessful extends CategoryWithEpiState{
  final CatwithEpi result;
  CategoryWithEpiSuccessful(this.result);
  @override

  List<Object> get props => [result];
}


class CategoryWithEpiFailed extends CategoryWithEpiState{}
//Bloc

class CategoryWithEpiBloc extends Bloc<CategoryWithEpiEvent,CategoryWithEpiState>{
  CategoryWithEpiBloc(CategoryWithEpiState initialState) : super(initialState);

  CategoryWithEpiState get initialState => AppIsClosed();

  @override
  Stream<CategoryWithEpiState> mapEventToState(CategoryWithEpiEvent event) async*{
    if(event is FetchCategoryWithEpi){
      yield CategoryWithEpiIsLoading();
      try{
        CatwithEpi result = await  fetchCatawithepi();
        yield (CategoryWithEpiSuccessful(result));
      }
      catch(e){
        yield CategoryWithEpiFailed();
      }


    }

  }


}