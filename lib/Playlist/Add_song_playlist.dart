import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muzify/functions/functions.dart';
import 'package:muzify/models/box_class.dart';
import 'package:muzify/models/hivemodel.dart';
import 'package:muzify/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';



class songadd extends StatefulWidget {
  String playlistName;
  songadd({Key? key, required this.playlistName}) : super(key: key);

  @override
  _buildSheetState createState() => _buildSheetState();
}

class _buildSheetState extends State<songadd> {
  final box = Boxes.getinstance();

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  getSongs() {
    DatabaseSongs = box.get("musics") as List<Localsongs>;
    playlistSongmodel = box.get(widget.playlistName)!.cast<Localsongs>();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: ListView.builder(
        
          itemCount: DatabaseSongs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  child: QueryArtworkWidget(
                    id: DatabaseSongs[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(15),
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/splashtwo.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
            
                },
                title: Text(
                  DatabaseSongs[index].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                   style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ) 
                  )
                ),
                trailing: playlistSongmodel
                        .where((element) =>
                            element.id.toString() ==
                            DatabaseSongs[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () async {
                          playlistSongmodel.add(DatabaseSongs[index]);
                          await box.put(widget.playlistName, playlistSongmodel);
                          //box.get(widget.playlistName);

                          setState(() {
                            // playlistSongs =
                            //     box.get(widget.playlistName)!.cast<Songs>();
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ))
                    : IconButton(
                        onPressed: () async {
                          // await box.put(widget.playlistName, playlistSongs);

                          playlistSongmodel.removeWhere((elemet) =>
                              elemet.id.toString() ==
                              DatabaseSongs[index].id.toString());

                          await box.put(widget.playlistName, playlistSongmodel);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        )),
              ),
            );
          },
        ));
  }
}