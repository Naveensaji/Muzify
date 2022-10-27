


// import 'dart:developer';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:muzify/functions/functions.dart';
// import 'package:muzify/functions/functions.dart';


// import '../functions/functions.dart';
// import '../nowplaying.dart';

// class Homepage extends StatefulWidget {

  
//    Homepage({Key? key, }) : super(key: key);
//    List<Audio> audiosongs = [];
 
//    @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//    AssetsAudioPlayer audioPlayer =AssetsAudioPlayer();



//    @override
//   void initState() {
//     super.initState();
//     // TODO: implement initState
  
//     databasesongs = box.get('musics');
//     fetchingsongs();
//   // log(audiosongs.length.toString());
    
//   }

//   @override
//   Widget build(BuildContext context) {
//       Size size =MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Column(
//             children: [
//               Container(
//                 child: SizedBox(
//               height: size.height*0.2,
          
//               child: ListView.builder(
//                 physics: ClampingScrollPhysics(),
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (BuildContext context, int index) => Container(
//                   child:  Container(
                  
//                           height: size.height*0.15,
//                          child: Card(
//                    color:  Color.fromARGB(100, 22, 44, 33),
//                    shape: RoundedRectangleBorder(
//                           borderRadius:BorderRadius.circular(20),
//                       ),
//                       child: Column(
          
//                           children: [
//                             ClipRRect(
//                                borderRadius: BorderRadius.circular(20),
//                               child: Image.asset('assets/images/card.jpg',  
//                               height: size.height*0.15,
//                               width: size.width*0.4,
//                               fit: BoxFit.cover,
//                                 ),
//                             ),
//                             const Text('Top Beats',style: TextStyle(fontSize: 18,color: Colors.white),),
                          
//                           ],
//                       ),
//                 ),
//                        ),
//                 ),
//               ),
//               )),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text('All Songs',
//                   style: TextStyle(fontSize: 25,color: Colors.white),
//                   ),
//                   const SizedBox(
//                height: 10,
//                   ),  
//                   Expanded(
//                     flex: 2,
//                     child: widget.audiosongs.isEmpty?Center(
//                       child: Text('No songs',style:TextStyle(color: Colors.white),),
//                     ):
//                     ListView.builder(
//                              shrinkWrap: true,
//                              itemBuilder: (context,index){
//                                return ListTile(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NowPlaying(index: index,myaudiosong: audiosongs,)));
//                     },
//                      title: Text('${widget.audiosongs[index].metas.title.toString()}',
//                      style: TextStyle(color: Colors.white,fontSize: 19),
//                      ),
//                      subtitle: Text(
//                             '${widget.audiosongs[index].metas.artist.toString()}',
//                             style: TextStyle(color: Colors.white,fontSize: 14),
//                           ),
//                       trailing: IconButton(onPressed: (){
//                     },
//                             icon: Icon(Icons.more_vert,color: Colors.white)
//                             ),
                          
                            
//                      leading: CircleAvatar(
//                     radius: 30,
//                     child: ClipOval(
//                     child: Image.asset('assets/images/splashtwo.jpg',
//                     width: size.width*0.3,
//                     height: size.height*0.2,
//                     ),
                            
//                     ),
//                       ),
                      
//                      );
//                              },
//                                itemCount: widget.audiosongs.length,
//                                ),
//                   )
//             ],
          
//           ),
//         ),
//       ],
//     );
//   }


// }