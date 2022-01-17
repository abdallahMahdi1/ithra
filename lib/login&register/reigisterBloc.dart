import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginApi.dart';
//Event
class RegisterEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class FetchRegister extends RegisterEvent{
  final String? username;
  final String? password;
  final String? email;
  FetchRegister({this.username,this.email,this.password});
  @override
  List<Object?> get props => [username,password,email];
}
//State
class RegisterState extends Equatable{
  @override
  List<Object?> get props =>[];

}

class UserNotRegistered extends RegisterState{}

class RegisterIsLoading extends RegisterState{}

class RegisterSuccessful extends RegisterState{
  final String? result;

  RegisterSuccessful(this.result);
  @override
  List<Object?> get props => [result];
}

class RegisterFailed extends RegisterState{}
//Bloc

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  RegisterBloc(RegisterState initialState) : super(initialState);

  RegisterState get initialState => UserNotRegistered();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if(event is FetchRegister){
      yield RegisterIsLoading();
      try{
        String? result  =await LoginAndRegister().getRegister(username: event.username,email:event.email,password:event.password);
        yield (RegisterSuccessful(result));

      }
      catch(e){
        yield RegisterFailed();
      }


    }

  }


}