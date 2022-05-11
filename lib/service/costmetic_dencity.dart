import 'package:flutter/material.dart';
class Costemetic_density extends StatefulWidget {
  const Costemetic_density({ Key? key }) : super(key: key);

  @override
  State<Costemetic_density> createState() => _Costemetic_densityState();
}

class _Costemetic_densityState extends State<Costemetic_density> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  ////  backgroundColor: Color.fromARGB(223, 255, 253, 253),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 1, 11, 66),
      //   title: Text("About us"),
      //   centerTitle: true,
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
                      SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          
                          Text("Cosmetic Dentistry", style: TextStyle(fontSize: 25 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                        ],),
                          SizedBox(height: 60,),
                 
                    Stack(children: [
                        Row(children: [

                          Container(height: 240,
                          width: 195,
                        child: Image.asset("images/before.jpg",fit: BoxFit.fill,),
                        
                        ),
                         Container(height: 240,
                         width:195,
                        child: Image.asset("images/after.jpg",fit: BoxFit.fill,),
                        
                        ),

                        ],),

                        Positioned(
                          left: 15, bottom: 0, top: 0, right: 10,
                          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            
                           Text("Before", style: TextStyle(fontSize: 22 , color: Colors.white ,fontWeight: FontWeight.bold,), ),
                           
                             Text("After", style: TextStyle(fontSize: 22 , color: Colors.white ,fontWeight: FontWeight.bold,), ),
                        ],))
                    ],),
                        SizedBox(height: 60,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Service Treatment", style: TextStyle( fontSize: 17 ,color: Colors.grey ,fontWeight: FontWeight.bold,), ),
                       ],
                     ),
                   ),
          ],),
        ),
      ),
   );
  }
}