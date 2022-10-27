import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muzify/widgets/recent.dart';

class CardOne extends StatelessWidget {
  const CardOne({super.key});

  @override
  Widget build(BuildContext context) {
     Size size =MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: () {
         Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => screenRecent()));
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
                                child: Image.asset('assets/images/card.jpg',  
                                height: size.height*0.15,
                                width: size.width*0.4,
                                fit: BoxFit.cover,
                                  ),
                              ),
                               Text('Recent songs', style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ) 
                  )),
                            
                            ],
                        ),
                      ),
                         ),
    );
  }
}