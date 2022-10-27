

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muzify/functions/functions.dart';
bool temp = true;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 bool islight = true;

  static bool toggleNotification({required bool isNotificationOn}) {
    isNotificationOn
        ? assetsAudioPlayer.showNotification = true
        : assetsAudioPlayer.showNotification = false;
    assetsAudioPlayer.showNotification ? temp = true : temp = false;

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 19, 168),
        leading: IconButton(onPressed: ( ){
            Navigator.of(context).pop();
        }, 
        icon: Icon(Icons.arrow_back)),
        title: Text('Settings'),
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

    child: ListView(
         children: [
           ListTile(
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.notification_add,color: Colors.white)),
            title: Text('Notifications',
               style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ) 
                  )
            ),
            trailing:Switch(
                activeColor: Colors.white,
                value: islight,
                onChanged: (value) {
                  bool temp = value;
                  temp = toggleNotification(isNotificationOn: value);
                  setState(() {
                    islight = temp;
                  });
                }),
          ),
            ListTile(
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.privacy_tip,color: Colors.white)),
            title: Text('Privacy and Plicy',
                style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ) 
                  )
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
            ListTile(
            leading: IconButton(onPressed: (){},
             icon: Icon(Icons.share,color: Colors.white)),
            title: Text('Share',
                style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ) 
                  )
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),
           ListTile(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return  LicensePage(
                    applicationName: 'M U Z F I Y',
                    applicationVersion: '1.0.0',
                  );
                }));
            },
            leading: IconButton(onPressed: (){
             },                                                                                
             icon: Icon(Icons.bookmarks_sharp,color: Colors.white)),
            title: Text('Terms and Conditions',
                style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ) 
                  )
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
                                                          Text(
                                                            "'Muzify' is a offline music player created by Naveen Saji",
                                                            textAlign:TextAlign.center,
                                                             style:GoogleFonts.lato(
                                                             textStyle:TextStyle(
                                                              
                                                             color: Colors.white,
                                                             fontSize: 18,
                                                             fontWeight: FontWeight.w800
                                                            ) ,
                                                            
                                      )
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
            leading: IconButton(onPressed: (){
             
            },
             icon: Icon(Icons.info,color: Colors.white)),
            title: Text('About',
               style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ) 
                  )
            ),
            trailing: IconButton(onPressed: (){},
             icon:Icon(Icons.arrow_right,color: Colors.white,)),
          ),  
         Expanded(child:SizedBox()),
         Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         
          children: [
             Text(
                'Version',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '1.0.0',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              )
          ],
         
         )
                 
                  ],
                  
                ),
                
                
        ),
        
    );
  }
}