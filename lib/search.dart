import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/mainpage.dart';
import 'package:muzify/widgets/drawer.dart';

// import 'package:music_player/open%20audio/openaudio.dart';

import 'package:muzify/widgets/miniplayer.dart';
import 'package:muzify/models/hivemodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  List<Audio> searchsong = [];
  SearchScreen({Key? key, required this.searchsong}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Localsongs> songsdb = [];
  List<Audio> songall = [];
  String search = '';

  getSongs() {
    songsdb = box.get("musics") as List<Localsongs>;

    for (var element in songsdb) {
      songall.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
  }

  Future<String> debounce() async {
    // await Future.delayed(const Duration(seconds: 1));
    return "Waited 1";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    List<Audio> searchresult = songall
        .where((element) =>
            element.metas.title!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 19, 168) ,
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx1) => MainPage(audiosongs: audiosongs)));
                               }, 
          icon: const Icon(Icons.arrow_back,
          color: Colors.white,
          )),
          title: const Text('Search',
          style: TextStyle(
            color: Colors.white
          ),
          ),
          actions: [
            IconButton(
              onPressed: (){
                 Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx1) => DrawerPage()));
              },
               icon: Icon(Icons.more_horiz_outlined))
          ],
      ),
     
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
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Container(
                child: TextField(
                    style: TextStyle(color:  Color.fromARGB(255, 93, 19, 168),),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 8, 59, 10), width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        suffixIcon: IconButton(
                            onPressed: () {
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx1) => MainPage(audiosongs: audiosongs)));
                            },
                            icon: Icon(
                              Icons.close,
                              color:  Color.fromARGB(255, 93, 19, 168),
                            )),
                        hintText: 'search a song',
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey)),
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      }); 
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            search.isNotEmpty
                ? searchresult.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: searchresult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: debounce(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: () {
                                       
                                        showBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            // elevation: 20,
                                            backgroundColor:
                                                Colors.blueGrey.withOpacity(0.8),
                                            context: context,
                                            builder: (ctx) => MiniPlayer(
                                                  index: index,
                                                  audiosongs: searchresult,
                                                ));
                                       
                                      },
                                      child: ListTile(
                                        leading: QueryArtworkWidget(
                                            id: int.parse(
                                                searchresult[index].metas.id!),
                                            type: ArtworkType.AUDIO,
                                            nullArtworkWidget: ClipOval(
                                              child: Image.asset(
                                                'assets/images/splashtwo.jpg',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        title: Text(
                                          searchresult[index].metas.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                          
                                              
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          searchresult[index].metas.artist!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "poppinz",
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "No result found",
                          style: TextStyle(
                            fontFamily: "poppinz",
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      )
                : const SizedBox()
          ],
        )),
      ),
    );
  }
}