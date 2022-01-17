import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginApi.dart';
//Event
class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class FetchLogin extends LoginEvent{
  final String? password;
  final String? email;
  FetchLogin({this.email,this.password});
  @override
  List<Object?> get props => [password,email];
}
class Logout extends LoginEvent{}
//State
class LoginState extends Equatable{
  @override
  List<Object> get props => [];

}

class UserNotLogined extends LoginState{}

class LoginIsLoading extends LoginState{}

class LoginSuccessful extends LoginState{
  final bool result;

  LoginSuccessful(this.result);
  @override
  List<Object> get props => [result];
}

class LoginFailed extends LoginState{}
//Bloc

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc(LoginState initialState) : super(initialState);

  LoginState get initialState => UserNotLogined();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is FetchLogin){
      yield LoginIsLoading();
      try{
        bool result  =await LoginAndRegister().getToken(email:event.email,password:event.password);
        yield (LoginSuccessful(result));

      }
      catch(e){
        yield LoginFailed();
      }


    }
    else if(event is Logout){
      yield UserNotLogined();
    }

  }


}