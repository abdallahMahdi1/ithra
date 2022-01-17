import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';


class AudioBloc extends Bloc<AudioEvent,AudioState>{
  AudioBloc(AudioState initialState) : super(initialState);

  AudioState get initialState => AudioIsNotSearched();
  final player = AssetsAudioPlayer();



  Stream<AudioState> mapEventToState(AudioEvent event) async*{
    if(event is FetchAudio) {
      yield AudioIsLoading();
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile) {
          await player.open (
            Audio.network(event.url!,
                metas:Metas(
                  album: event.showName,
                  artist: event.name,
                  image: MetasImage.network(event.img!),
                ) ),
            autoStart: true,
            showNotification: true,
            notificationSettings: NotificationSettings(
              prevEnabled: false,
              stopEnabled: false,
              nextEnabled: false,
              seekBarEnabled: true,
            ),
          );
          Duration max = player.current.value!.audio.duration ;


          yield AudioIsPlaying(player: player,max:max,name: event.name,image:event.img,showName:event.showName);
        }
        else if (connectivityResult == ConnectivityResult.wifi) {
          await player.open (
            Audio.network(event.url!,
                metas:Metas(
                  album: event.showName,
                  artist: event.name,
                  image: MetasImage.network(event.img!),
                ) ),
            autoStart: true,
            showNotification: true,
            notificationSettings: NotificationSettings(
              prevEnabled: false,
              stopEnabled: false,
              nextEnabled: false,
              seekBarEnabled: true,
            ),
          );
          Duration max = player.current.value!.audio.duration;


          yield AudioIsPlaying(player: player,max:max,name: event.name,image:event.img,showName:event.showName);
        }
        else if (connectivityResult == ConnectivityResult.none){
          yield AudioIsFailed(name:event.name,img: event.img,showName: event.showName,url: event.url );
        }



      } catch (t) {
        yield AudioIsFailed(name:event.name,img: event.img,showName: event.showName,url: event.url);

      }
    }

  }
}
// Event
class AudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class FetchAudio extends AudioEvent{
  final String? url;
  final String? name;
  final String? img;
  final String? showName;


  FetchAudio({this.name, this.img, this.url,this.showName});
  @override
  List<Object?> get props => [url,name,img,name];
}


class RestAudio extends AudioEvent{}

//state
class AudioState extends Equatable{
  @override
  List<Object?> get props => [];

}

class AudioIsNotSearched extends AudioState{}

class AudioIsLoading extends AudioState{}

// ignore: must_be_immutable
class AudioIsPlaying extends AudioState{
  final name;
  final image;
  final showName;
  Duration? max ;
  AssetsAudioPlayer? player = AssetsAudioPlayer();
  AudioIsPlaying({ this.player,this.max,this.name,this.image,this.showName});
  @override
  List<Object?> get props => [player];

}
class AudioIsFailed extends AudioState{

  final String? url;
  final String? name;
  final String? img;
  final String? showName;
  AudioIsFailed({required this.name,required this.img,required this.url,required this.showName});
  @override
  List<Object?> get props => [url,name,img,name];


}

