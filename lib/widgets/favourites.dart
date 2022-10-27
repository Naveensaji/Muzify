
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/nowplaying.dart';
import 'package:muzify/open%20audio/openaudio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

    bool _isfavorite = false;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable:box.listenable(),
         builder:(context,Boxes,_){
          final likedsongs = box.get("favorites");
              if (likedsongs == null || likedsongs.isEmpty) {
                return const Center(
                  child: Text(
                    'No Favourites',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                );
               }
               else{
                return ListView.builder(itemBuilder: (context,index)=>
                GestureDetector(
                  onTap: () {
                   
                    
                  },
                   child: ListTile(
            onTap: () {
             for (var element in likedsongs) {
                        PlayLikedSong.add(
                          Audio.file(
                            element.uri!,
                            metas: Metas(
                              title: element.title,
                              id: element.id.toString(),
                              artist: element.artist,
                            ),
                          ),
                        );
                      }
                      PlayMyAudio(allsongs: PlayLikedSong, index: index)
                          .openAsset(index: index, audios: PlayLikedSong);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>NowPlaying(
                                    index: index,
                                    myaudiosong: PlayLikedSong,
                                  )));
            },
             title:Text(
                        likedsongs[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                       style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ) 
                  )
                      ),
             subtitle:  Text(
                        likedsongs[index].artist == '<unknown>'
                            ? 'unknown Artist'
                            : likedsongs[index].artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                       style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 13
                    ) 
                  )
                      ),
             leading:QueryArtworkWidget(
                          id: likedsongs[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipOval(
                            child: Image.asset(
                              'assets/images/splashtwo.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )),
             trailing:
             IconButton(onPressed: (){
             setState(() {
                likedsongs.removeAt(index);
              box.put("favorites", likedsongs);
             });
             // ignore: prefer_const_constructors
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Removed From Favourites',
              style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
              ),
              backgroundColor: Colors.red,
               behavior: SnackBarBehavior.floating,
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10))
              )
              );

             },
              icon: Icon(Icons.favorite,
              color: Colors.white,))
              
              
             ),
                ),
        
            
        itemCount: likedsongs.length,
        );

               }
         }
          ),
      
      
    );
  }
}