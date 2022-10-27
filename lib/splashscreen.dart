
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzify/SplashTwo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


void initState() {
    // TODO: implement initState
    super.initState();
    splashtwo();
  }


@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  Widget build(BuildContext context) {
    return Scaffold(

   body:Container(
    decoration: const BoxDecoration(
                // ignore: unnecessary_const
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 93, 19, 168),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                )),
     child: Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Center(
         child: Image.asset('assets/images/logo2-removebg-preview.png',
        ),
         ),
         // ignore: prefer_const_constructors
         SizedBox(
          height: 20,

         ),
          Text('Muzify',style:GoogleFonts.lato(
                    textStyle:TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ) 
                  ),),
         
         ]
     ),
        ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

   Future<void>splashtwo() async{
  await  Future.delayed(Duration(seconds: 3));
   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SplashTwo()
    )
    );
    
  }
}