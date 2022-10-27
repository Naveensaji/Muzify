
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/functions/functions.dart';
import 'package:muzify/mainpage.dart';

class SplashTwo extends StatefulWidget {
  const SplashTwo({Key? key}) : super(key: key);

  @override
  State<SplashTwo> createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     mainpage();
    fetchingsongs();
   
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Stack(
          children: 
            [Container(
             width: double.infinity,
             height: double.infinity,
              child: Image.asset('assets/images/sps2.jpg',
              fit: BoxFit.cover,
                 ),
              
            ),
            Positioned(
              left: 15,
              bottom: 60,
              child: Text('Listen to the music  \n you Love ....!',style:GoogleFonts.oswald(
                      textStyle:TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1
                      ) 
                    ),),
            )
          ],
        )
      );
    
    

    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<void>mainpage() async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MainPage(audiosongs: audiosongs,)
    )
    );
    
  }
}