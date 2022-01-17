import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/Subscriber_fetch.dart';
import 'package:ithra/modules/Subscriber_module.dart';
//Event
class SubscriberEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchSubscriber extends SubscriberEvent{}
//State
class SubscriberState extends Equatable{
  @override
  List<Object> get props =>  [];

}

class AppIsClosed1 extends SubscriberState{}

class SubscriberIsLoading extends SubscriberState{}

class SubscriberSuccessful extends SubscriberState{
  final Subscriber result;
  SubscriberSuccessful(this.result);
  @override
  List<Object> get props => [result];
}


class SubscriberFailed extends SubscriberState{}
//Bloc

class SubscriberBloc extends Bloc<SubscriberEvent,SubscriberState>{
  SubscriberBloc(SubscriberState initialState) : super(initialState);

  SubscriberState get initialState => AppIsClosed1();

  @override
  Stream<SubscriberState> mapEventToState(SubscriberEvent event) async*{
    if(event is FetchSubscriber){

      yield SubscriberIsLoading();
      try{
        Subscriber result = await fetchSubscriber();
        yield (SubscriberSuccessful(result));
      }
      catch(e){
        yield SubscriberFailed();
      }


    }

  }


}