
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/mainpage.dart';
import 'package:muzify/search.dart';
import 'package:muzify/widgets/recent.dart';
import 'package:muzify/widgets/settings.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple.shade800,
      child: Container(
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: 
                  DrawerHeader(
                     child: Row(
                       children: [
                         Text('Muzify',
                  style:GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white, fontSize: 28
                  )
                  )
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ClipRRect(
                    child: Image(image: AssetImage('assets/images/logo2-removebg-preview.png',
                    
                    ),
                    width: 50,
                    height: 50,),
                  )
                       ],
                     ),
                  ),
         
               
            ),
          
          ListTile(
            onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainPage(audiosongs: audiosongs,)));
            },
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.home,color: Colors.white)),
            title: Text('All songs',
             style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){
              
            },
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
          ListTile(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainPage(audiosongs: audiosongs,)));
            },
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.favorite,color: Colors.white)),
            title: Text('Favourites',
               style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
           ListTile(
            onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => screenRecent()));
            },
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.recent_actors,color: Colors.white,)),
            title: Text('Recents',
              style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
           ListTile(
            onTap: () {
               Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => SearchScreen(searchsong:audiosongs )));
            },
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.search,color: Colors.white,)),
            title: Text('Search',
               style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
           ListTile(
            onTap: (() {
              
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SettingsPage()));
            }),
            leading: IconButton(onPressed: (){ },
             icon: Icon(Icons.settings,color: Colors.white,)),
            title: Text('Settings',
               style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
           ListTile(
            onTap: () {
               showDialog(
                context: context
              , builder: ((ctx) {
                return Dialog(
                backgroundColor:  Color.fromARGB(255, 57, 0, 113),
                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(40))
                                                 ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            40.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      width: 500,
                                                      height: 135,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "'Muzify' is a offline music player created by Naveen Saji",
                                                            style: 
                                                          
                                                            TextStyle(
                                                              
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                                    textAlign: TextAlign.center,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary: Colors
                                                                            .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10))),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Ok',
                                                                      style:
                                                                          TextStyle(color: Colors.black),
                                                                    )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
              }
              )
              );
            },
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.info,color: Colors.white,)),
            title: Text('About',
               style: GoogleFonts.lato(
              textStyle:TextStyle(color: Colors.white, fontSize: 20)
             ),
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
            ],
        ),
      ),
    
    );
  }
}