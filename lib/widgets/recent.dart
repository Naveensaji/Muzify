

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzify/mainpage.dart';
import 'package:muzify/open%20audio/openaudio.dart';
import 'package:muzify/search.dart';
import 'package:muzify/widgets/drawer.dart';
import 'package:muzify/widgets/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';


import '../functions/functions.dart';

class screenRecent extends StatefulWidget {
  screenRecent({Key? key}) : super(key: key);

  @override
  State<screenRecent> createState() => _screenRecentState();
}

class _screenRecentState extends State<screenRecent> {
  List<Audio> recentAudlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainPage(audiosongs: audiosongs,)));
       },
        icon: Icon(Icons.arrow_back_ios_outlined),),
        backgroundColor: Color.fromARGB(255, 93, 19, 168),
        title: Text("Recently Played",
            style: const TextStyle(
               fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.w500),
           ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen(searchsong: audiosongs,)));
              },
              icon: Icon(Icons.search),color: Colors.white,)
        ],
      ),
      drawer: const DrawerPage(),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Boxes, _) {
                final recentsongs = box.get("recent");
                if (recentsongs == recentsongs?.isEmpty) {
                  return Center(
                    child: Text("No Recents",
                        style: const TextStyle(
                            fontFamily: "poppinz",
                            fontSize: 18,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                       ),
                  );
                } else {
                  return ListView.builder(
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              for (var element in recentsongs) {
                                recentAudlist.add(
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
                              PlayMyAudio(allsongs: recentAudlist, index: index)
                                  .openAsset(index: index, audios: recentAudlist);

                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                  context: context,
                                  builder: (ctx) => MiniPlayer(
                                        index: index,
                                        audiosongs: recentAudlist,
                                      ));
                            },
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                  id: recentsongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipOval(
                                    child: Image.asset(
                                      'assets/images/splashtwo.jpg',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    recentsongs.removeAt(index);
                                    box.put("recent", recentsongs);
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                      "Removed From Recents",
                                      style: TextStyle(
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
                                icon: const Icon(
                                  Icons.close_sharp,
                                  color: Color(0xffdd0021),
                                ),
                              ),
                              title: Text(
                                recentsongs[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                recentsongs[index].artist == '<unknown>'
                                    ? 'unknown Artist'
                                    : recentsongs[index].artist,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                      itemCount: recentsongs!.length);
                }
              }),
        ),
      ),
    );
  }
}