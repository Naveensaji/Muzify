import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
// import 'package:music_player/functions/functions.dart';
import 'package:muzify/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/functions.dart';

class MiniPlayer extends StatefulWidget {
  int index;
  List<Audio> audiosongs = [];

  MiniPlayer({Key? key, required this.index, 
  required this.audiosongs})
      : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer assetsaudioplayer = AssetsAudioPlayer.withId('0');
  bool prevvisible = true;
  bool nxtvisible = true;
 bool nextDone = true;
  bool preDone = true;


  buttondesable() {
    if (widget.index == 0) {
      prevvisible = false;
    } else {
      prevvisible = true;
    }

    if (widget.index == audiosongs.length - 1) {
      nxtvisible = false;
    } else {
      nxtvisible = true;
    }
  }

  @override
  void initState() {
    buttondesable();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return assetsaudioplayer.builderCurrent(
        builder: (context, Playing? playing) {
      final myAudio = find(audiosongs, playing!.audio.assetAudioPath);
      // int? index;
      return SizedBox(
          // color: Colors.white.withOpacity(0.1),
          height: size.height * 0.12,
          child: Container(
              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                 
                                
                  // ignore: unnecessary_const
                                gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                                colors: [
                                   Color.fromARGB(255, 93, 19, 168),
                                   Color.fromARGB(255, 36, 33, 33)
                             ],
                             
                             )),
            child: ListTile(
              // tileColor: Color.fromARGB(255, 83, 7, 160),
              contentPadding: EdgeInsets.only(bottom: 15, left: 5, top: 10),
              // contentPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              leading: QueryArtworkWidget(
                id: int.parse(myAudio.metas.id!),
                artworkFit: BoxFit.fill,
                artworkBorder: BorderRadius.circular(20),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipOval(
                  child: Image.asset(
                    'assets/images/logo3.jpg',
                    
                    width: 45,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                     NowPlaying(index: widget.index, myaudiosong: audiosongs),
                ));
              },
              title: Marquee(
                text: myAudio.metas.title.toString(),
                pauseAfterRound: const Duration(seconds: 3),
                velocity: 10,
                blankSpace: 10,
                style: TextStyle(
                    fontFamily: "poppinz",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
             
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prevvisible
                      ? Visibility(
                          visible: prevvisible,
                          child: IconButton(
                              onPressed: () {
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
                              icon: Icon(
                                Icons.skip_previous_sharp,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      : SizedBox(
                          width: 30,
                        ),
                  PlayerBuilder.isPlaying(
                      player: assetsAudioPlayer,
                      builder: (context, isPlaying) {
                        return GestureDetector(
                          onTap: () async {
                            await assetsAudioPlayer.playOrPause();
                          },
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        );
                      }),
                  nxtvisible
                      ? Visibility(
                          visible: nxtvisible,
                          child: IconButton(
                              onPressed: () {
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
                              },
                              icon: Icon(
                                Icons.skip_next_sharp,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      : SizedBox(
                          width: 30,
                        )
                ],
              ),
            ),
          )
          );
    });
  }
}