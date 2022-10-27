
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/mainpage.dart';
import 'package:muzify/models/hivemodel.dart';
import 'package:on_audio_query/on_audio_query.dart';


class NowPlaying extends StatefulWidget {
 Audio ? songs;
 List<Audio>myaudiosong = [];
 int index;

   NowPlaying({
    required this.myaudiosong,
    required this.index,
    songs,
    Key? key,
 
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
 bool nextDone = true;
  bool preDone = true;

  bool _isplaying = true;
    int repeat = 0;
  double _currentsliderValue = 20;
  List<dynamic> likedSongS = [];
   bool prevvisible = true;
  bool nxtvisible = true;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

@override
  void initState() {
    // TODO: implement initState
    // PlaySong();
    super.initState();
    DatabaseSongs = box.get('musics') as List<Localsongs>;
    assetsAudioPlayer.play();

  }
   @override
  Widget build(BuildContext context) {
      
     Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 93, 19, 168),
        centerTitle: true,
        leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
        },
         icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text('Playing now'),
        actions: [
          IconButton(onPressed: (){},
           icon: const Icon(Icons.density_medium))
        ],
        ),
        body:
        assetsAudioPlayer.builderCurrent(
          builder: (context, Playing? playing)  {
        final myAudio = find(widget.myaudiosong, playing!.audio.assetAudioPath);
        final currentSong = DatabaseSongs.firstWhere(
            (element) => element.id.toString() == myAudio.metas.id.toString());
        if (playing.audio.assetAudioPath.isEmpty) {
          return Center(
            child: Text('Loading....!!!'),
          );
        } else{
        
        return Container(
           decoration: const BoxDecoration(
                  // ignore: unnecessary_const
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                     Color.fromARGB(255, 93, 19, 168),
                     Color.fromARGB(255, 36, 33, 33)
                    ],
                  )),
                 child: Column(
                 children:[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:Container(
                       width: size.width*0.9,
                      height: size.height*0.5,
                      child: QueryArtworkWidget(
                        id:  int.parse(myAudio.metas.id!),
                        nullArtworkWidget:  ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                             child: Image.asset('assets/images/logo3.jpg',
                                                   width: size.width*0.9,
                                                   height: size.height*0.5,
                                                   ),
                          ),
                         type:  ArtworkType.AUDIO,
                         artworkBorder: BorderRadius.circular(90) ,
                         
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                      Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                 Container(
                                  width: size.width*0.8,
                                   child: Text(myAudio.metas.title.toString() == '<unknown>'
                    ? 'unknown'
                    : myAudio.metas.title.toString(),
                        overflow: TextOverflow.ellipsis,
                maxLines: 1,
                                style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ) 
                  )
                                
                                ),
                                 ),
                                // ignore: prefer_const_constructors
                                Text( myAudio.metas.artist.toString() == '<unknown>'
                    ? 'unknown Artist'
                    : myAudio.metas.artist.toString(),
                        overflow: TextOverflow.fade,
                maxLines: 1,
                                  style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                    ) 
                  )
                             
                                )
                              ],
                            ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                             likedSongS
                            .where((element) =>
                                element.id.toString() ==
                                currentSong.id.toString())
                            .isEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.favorite_outline,
                              size: 27,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              likedSongS.add(currentSong);
                              box.put("favorites", likedSongS);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  "Added to Favourites",
                                  style: TextStyle(
                                    fontFamily: "poppinz",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor:  Color.fromARGB(255, 93, 19, 168),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));

                              setState(() {});
                            },
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              size: 27,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                likedSongS.removeWhere((elemet) =>
                                    elemet.id.toString() ==
                                    currentSong.id.toString());
                                box.put("favorites", likedSongS);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  "Removed From Favourites",
                                  style: TextStyle(
                                    fontFamily: "poppinz",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: const Color(0xffdd0021),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                            },
                          ),
                           
                           
                           
                            ],
                           ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                        Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: assetsAudioPlayer.builderRealtimePlayingInfos(
                      builder: (context, infos) {
                    Duration currentposition = infos.currentPosition;
                    Duration totalduration = infos.duration;
                    return ProgressBar(
                        timeLabelTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                        thumbColor: Colors.white,
                        baseBarColor: Colors.grey,
                        progressBarColor:  const Color.fromARGB(255, 93, 19, 168),
                        bufferedBarColor:   const Color.fromARGB(255, 93, 19, 168),
                        thumbRadius: 10,
                        barHeight: 4,
                        progress: currentposition,
                        total: totalduration,
                        onSeek: ((to) {
                          assetsAudioPlayer.seek(to);
                        }));
                  })),
               
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [         
                    InkWell(
                      child: IconButton(onPressed: (){
                         setState(() {
                          assetsAudioPlayer.toggleShuffle();
                        });
                      },
                       icon: assetsAudioPlayer.isShuffling.value
                          ? const Icon(
                              Icons.shuffle_on_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            ))
                    ),
                     IconButton(onPressed: (){
                     setState(()async {
                                  widget.index = widget.index + 1;
                                  if (widget.index != audiosongs.length - 1) {
                                    nxtvisible = true;
                                  }
                                    if (preDone) {
                                    preDone = false;
                                    await assetsAudioPlayer.previous();
                                    preDone = true;
                                  }
                                 // assetsAudioPlayer.previous();
                                });
                     },
                     icon: Icon(Icons.skip_previous_rounded),color: Colors.white,iconSize: 55,),
                   
                      PlayerBuilder.isPlaying(
                      player: assetsAudioPlayer,
                      builder: (context, isPlaying) {
                        return GestureDetector(
                          onTap: () async {
                            await assetsAudioPlayer.playOrPause();
                          },
                          child: Icon(
                            isPlaying ? Icons.pause_circle_filled_outlined : Icons.play_circle_fill,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      }
                      ),
                     IconButton(onPressed: (){
                      setState(()async {
                                  widget.index = widget.index + 1;
                                  if (widget.index > 0) {
                                    prevvisible = true;
                                  }
                                   if (nextDone) {
                                    nextDone = false;
                                    await assetsAudioPlayer.next();
                                    nextDone = true;
                                  }
                                 // assetsAudioPlayer.next();
                                });
                                 addrecent(index: widget.index);
                     },
                     icon: Icon(Icons.skip_next_rounded),color: Colors.white,iconSize: 55,),
                     IconButton(onPressed: (){
                       setState(() {
                          if (repeat % 2 == 0) {
                            assetsAudioPlayer.setLoopMode(LoopMode.single);
                            repeat++;
                          } else {
                            assetsAudioPlayer.setLoopMode(LoopMode.none);
                            repeat++;
                          }
                        });
                     },
                     icon:repeat % 2 == 0
                          ? const Icon(
                              Icons.loop,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.repeat_on_rounded,
                              color: Colors.white,
                            )),
                    
                  ],
                 )
                    ]
                  ),
        
            );
        
          }
          }

    )

    );
  }

   
}