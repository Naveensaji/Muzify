import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/mainpage.dart';

class CardFour extends StatelessWidget {
  const CardFour({super.key});

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
                     return  GestureDetector(
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainPage(audiosongs: audiosongs,)));
                      },
                       child: Container(
                                         
                              height: size.height*0.15,
                            child: Card(
                                         color:  Color.fromARGB(100, 22, 44, 33),
                                         shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(20),
                          ),
                          child: Column(
                                 
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset('assets/images/plyst3.jpg',  
                                  height: size.height*0.15,
                                  width: size.width*0.4,
                                  fit: BoxFit.cover,
                                    ),
                                ),
                                 Text('All songs',style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ) 
                  ),),
                              
                              ],
                          ),
                        ),
                          ),
                     );
  }
}