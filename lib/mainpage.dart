
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/Playlist/add_to_playlist_from_home.dart';
import 'package:muzify/cards/card1.dart';
import 'package:muzify/cards/card2.dart';
import 'package:muzify/cards/card3.dart';
import 'package:muzify/cards/card4.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/models/hivemodel.dart';
import 'package:muzify/open%20audio/openaudio.dart';
import 'package:muzify/search.dart';
import 'package:muzify/widgets/drawer.dart';
import 'package:muzify/widgets/favourites.dart';
import 'package:muzify/widgets/miniplayer.dart';
import 'package:muzify/widgets/playlistTab.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<dynamic>? recentsongsdy = [];
List<dynamic> recents = [];

class MainPage extends StatefulWidget {

   MainPage({Key? key,required this.audiosongs
  

  }) : super(key: key);
    List<Audio> audiosongs = [];
   
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   List<dynamic>? likedsongs = [];
 Future refreshlist() async {
    setState(() {});
    fetchingsongs();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    // TODO: implement initState

    databasesongs = box.get('musics');
    likedsongs = box.get("favorites");
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Muzify',
          style: GoogleFonts.lato(),
          ),
          centerTitle: true,
          backgroundColor:  Color.fromARGB(255, 93, 19, 168),
            actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchsong: audiosongs))
                          );
        },
      )
      ],
      
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.favorite)),
          Tab(icon: Icon(Icons.home_filled)),
          Tab(icon: Icon(Icons.playlist_add_check_outlined)),
        ],
      ),
      ),
      drawer:DrawerPage(),
      body:
      
       Container(
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
             child: TabBarView(children:[ 
            Favourites(),
           Column(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                child: SizedBox(
              height: size.height*0.2,
          
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                 CardOne(),
                 CardTwo(),
                 CardThree(),
                 CardFour(),
                
                 ],
                 
                  ),
              )),
              const SizedBox(
                height: 10,
              ),  
               Text('All Songs',
                  style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ) 
                  )
                  ),
                  const SizedBox(
               height: 10,
                  ),  
                  Expanded(
                    flex: 2,
                    child:audiosongs.isEmpty
                    ?
                     Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No Songs,Try to Refresh it!!",
                          style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ) 
                  )
                          ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:  Color.fromARGB(255, 93, 19, 168),
                        ),
                        onPressed: () {
                          refreshlist();
                        },
                        child: const Text(
                          'Refresh ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "poppinz",
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                    :
                    RefreshIndicator(
                      onRefresh: refreshlist,       
                      child: ListView.builder(
                               shrinkWrap: true,
                               itemBuilder: (context,index){
                                 return ListTile(
                      onTap: () {
                      showBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Colors.purple,
                        context: context,
                       builder: ((context) => MiniPlayer(
                        index: index, 
                        audiosongs: audiosongs)
                       )
                        );
                        
                      PlayMyAudio(index: index, allsongs: widget.audiosongs)
                          .openAsset(audios: audiosongs, index: index);
                          addrecent(index: index);
                      },
                       title: Text('${audiosongs[index].metas.title.toString()}',
                       style:GoogleFonts.lato(
                      textStyle:TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ) 
                                      )
                       ),
                       subtitle:
                       
                        Text(audiosongs[index].metas.artist.toString() == '<unknown>' ? 'Unknown Artist' :
                              '${audiosongs[index].metas.artist.toString()}',
                              style:GoogleFonts.lato(
                      textStyle:TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800
                      ) 
                                      )
                            ),
                        trailing: IconButton(onPressed: (){
                           showDialog(context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Container(
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                   
                                  
                                      // ignore: unnecessary_const
                                  gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                     Color.fromARGB(255, 93, 19, 168),
                                     Color.fromARGB(255, 36, 33, 33)
                               ],
                               
                               
                               )),
                               child: Padding(padding: EdgeInsets.all(10.0),
                               child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      
                                       Navigator.of(context).pop();
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Color(0xff091127),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20))),
                                                context: context,
                                                builder: (context) => PlaylistNow(
                                                    song: widget
                                                        .audiosongs[index]));
                                    },
                                    leading: IconButton(onPressed: (){},
                                     icon: const Icon(Icons.playlist_add_circle_rounded,color: Colors.white,)),
                                    title: const Text("Add To Playlist",
                                    style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                likedsongs!
                                                .where((element) =>
                                                    element.id.toString() ==
                                                    databasesongs![index]
                                                        .id
                                                        .toString())
                                                .isEmpty
                                                ?ListTile(
                                                  leading: IconButton(onPressed: (){},
                                             icon: Icon(Icons.favorite,color: Colors.white,)),
                                                  title: Text('Add to Favourites',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  onTap: () {
                                                    final songs = box.get("musics")as List<Localsongs>;
                                                    final temp = songs.firstWhere(
                                                      (element) => element.id.toString()==
                                                      widget.audiosongs[index].metas.id.toString()
                                                      );
                                                      favorites= likedsongs!;
                                                      favorites.add(temp);
                                                      box.put("favorites", favorites);
                                                      ScaffoldMessenger.of(context).showSnackBar
                                                      (SnackBar(
                                                      
                                                        content: const Text('Added to Favourites',
                                                         style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold
                                                        )
                                                        ),
                                                        
                                                        behavior: SnackBarBehavior.floating,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        backgroundColor: Color.fromARGB(255, 93, 19, 168)
                                                      ),
                                                );
                                                          Navigator.of(context).pop();
                    
                                                  },
                                                )
                                                :ListTile(
                                                   leading: IconButton(onPressed: (){},
                                                      icon: Icon(Icons.remove_circle_outline,color: Colors.white,)),
                                                  title: Text('Remove From Favourites',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                 onTap: () async{
                                                     likedsongs?.removeWhere(
                                                      (elemet) =>
                                                          elemet.id.toString() ==
                                                          databasesongs![index]
                                                              .id
                                                              .toString());
                                                  await box.put(
                                                      "favorites", likedsongs!);
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context).showSnackBar
                                                      (SnackBar(
                                                        duration: Duration(seconds: 2),
                                                      content: const Text('Removed From Favourites',
                                                         style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold
                                                        )
                                                        ),
                                                        
                                                        behavior: SnackBarBehavior.floating,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        backgroundColor: Colors.red,
                                                        
                                                        
                                                      ),
                                                );
                    
                                                  Navigator.of(context).pop();
                                                    
                                                  },
                    
                                                )
                                                ],
                               ),
                               ),
                                ),
                    
                              );
                    
                            }
                            );
                      },
                              icon: Icon(Icons.more_vert,color: Colors.white)
                              ),
                            
                              
                       leading: QueryArtworkWidget(
                        id: int.parse(
                         widget.audiosongs[index].metas.id.toString()),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget:ClipOval(
                      
                       child: Image.asset('assets/images/splashtwo.jpg',
                       width:50,
                       height: 50,
                       fit: BoxFit.cover,
                       
                       ),
                               
                       ),
                        )
                      
                       );
                               },
                                 itemCount: audiosongs.length,
                                 ),
                    ),
                  )
            ],
          
          ),
        ),
      ],
    ),
   
           Playlist_tab(),
             ]
             ),
      ),
       ),
    );
  }

 
}
addrecent({required int index}) {
  if (recents.length < 10) {
    final songs = box.get("musics") as List<Localsongs>;

    final temp = songs.firstWhere((element) =>
        element.id.toString() == audiosongs[index].metas.id.toString());
    recents = recentsongsdy!;
    recents.add(temp);
    box.put("recent", recents);
  } else {
    recents.removeAt(0);
    box.put("recent", recents);
  }
}