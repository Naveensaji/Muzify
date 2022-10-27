import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:muzify/models/box_class.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/hivemodel.dart';
List<SongModel> allSongs = [];
final box = Boxes.getinstance();
final _audioquery = OnAudioQuery();
List<Audio> audiosongs = [];
List<Localsongs>mappedsongs=[];
List<Localsongs> DatabaseSongs = [];
List? databasesongs = [];
List<dynamic> favorites = [];
List<Audio> PlayLikedSong = [];

fetchingsongs()async{

  bool ispermisson = await _audioquery.permissionsStatus();
  if(!ispermisson){
    await _audioquery.permissionsRequest();
  }
  allSongs = await _audioquery.querySongs();
  mappedsongs = allSongs
  .map((e) => Localsongs(
    title: e.title, 
    artist: e.artist,
    id: e.id,
    uri: e.uri,
    duration: e.duration!)).toList();

    await box.put("musics", mappedsongs);
    DatabaseSongs = box.get("musics")as List<Localsongs>;

    DatabaseSongs.forEach((element) {
      audiosongs.add(Audio.file(element.uri.toString(),
    
      metas: Metas(
        title: element.title,
        id: element.id.toString(),
        artist: element.artist
      )
      )
      );
    },
   
    );
    
}
Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
//Playlist-->
List playlists = [];
String? playlistName = '';

List<dynamic>? playlistSongs = [];

List<Audio> playlistsplay = [];

List<Localsongs> playlistSongmodel = [];