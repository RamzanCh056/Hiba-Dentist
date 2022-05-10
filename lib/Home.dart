import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hiba_dentist/drawer.dart';
import 'package:hiba_dentist/model/before_after.dart';
import 'package:hiba_dentist/model/feedback_model.dart';
import 'package:hiba_dentist/model/services.dart';
import 'package:hiba_dentist/model/slider_model.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_indicator/loading_indicator.dart';
  var first = 'http://drhibasaadeh.com';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future<before_after> beforeafter() async {
    var headers = {
      'Authorization': 'Bearer 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };

// var request = http.Request('GET', Uri.parse('http://drhibasaadeh.com/api/patients/beforeAfterImg/'));
    var request = await http.get(
        Uri.parse('http://drhibasaadeh.com/api/patients/beforeAfterImg/'),
        headers: headers);
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();
    var data = jsonDecode(request.body.toString());

    if (request.statusCode == 200) {
      // print(await response.stream.bytesToString());
      print("api is hit");
      return before_after.fromJson(data);
    } else {
      // print(response.reasonPhrase);
      print("api not hit");
      return before_after.fromJson(data);
    }
  }


   List<slider_model> photosList = [];
    Future<List<slider_model>> sliderfunction() async {
      
    var headers = {
      'Authorization': 'Bearer 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };

// var request = http.Request('GET', Uri.parse('http://drhibasaadeh.com/api/patients/beforeAfterImg/'));
    var request = await http.get(
        Uri.parse('http://drhibasaadeh.com/api/patients/carousel/'),
        headers: headers);
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();
    var data = jsonDecode(request.body.toString());

    if (request.statusCode == 200) {
         for(Map i in data){
        slider_model photos = slider_model(carouselImage: i['carousel_image']);
        photosList.add(photos);
      }
      // print(await response.stream.bytesToString());
      print("api is hit on carsol");
      return  photosList;
    
    } else {
      // print(response.reasonPhrase);
      print("api not hit");
      return photosList;
    }
  }

  // services function
  
   List<services> photoList = [];
    Future<List<services>> servicesfunction() async {
      
    var headers = {
      'Authorization': 'Bearer 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };

// var request = http.Request('GET', Uri.parse('http://drhibasaadeh.com/api/patients/beforeAfterImg/'));
    var request = await http.get(
        Uri.parse('http://drhibasaadeh.com/api/patients/services/'),
        headers: headers);
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();
    var data = jsonDecode(request.body.toString());

    if (request.statusCode == 200) {
         for(Map i in data){
        services photos = services(serviceImage: i['service_image']);
        photoList.add(photos);
      }
      // print(await response.stream.bytesToString());
      print("api is hit on carsol");
      return  photoList;
    
    } else {
      // print(response.reasonPhrase);
      print("api not hit");
      return photoList;
    }
  }

  // feedback function
  List<fedback_model> feedbacklist = [];
    Future <List<fedback_model>> feedbackfunnction() async {
    var headers = {
      'Authorization': 'Bearer 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };

// var request = http.Request('GET', Uri.parse('http://drhibasaadeh.com/api/patients/beforeAfterImg/'));
    var request = await http.get(
        Uri.parse('http://drhibasaadeh.com/api/patients/feedback/'),
        headers: headers);
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();
    var data = jsonDecode(request.body.toString());

    if (request.statusCode == 200) {
         for(Map i in data){
        fedback_model photos = fedback_model(  description:  i['description'], firstName: i['first_name'] , lastName: i['last_name']);
        feedbacklist.add(photos);
      }
      // print(await response.stream.bytesToString());
      print("api is hit on carsol");
      return feedbacklist;
    
    } else {
      // print(response.reasonPhrase);
      print("api not hit");
      return feedbacklist;
    }
  }
    launchURLone( String url, ) async {
    if (await canLaunch(url)) {
      await launch(url, 
      forceWebView: true,
      enableJavaScript: true,
      forceSafariVC: true,

      );
    } else {
      throw 'Could not launch $url';
    }
 }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: newdrawerpage(),
      ),
      backgroundColor: Color.fromARGB(223, 255, 253, 253),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 11, 66),
        title: Text("Home"),
        centerTitle: true,
      ),
      // body: SingleChildScrollView(
        // physics: ScrollPhysics(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [



              // CarouselSlider(
              //   items: [
                            
                         
                         FutureBuilder(
                                           future: sliderfunction(),
                                           builder: (context,AsyncSnapshot<List<slider_model>> snapshot) {
                                             if (snapshot.data != null) {
                           
                          return ListView.builder(
                              shrinkWrap: true,
                              // scrollDirection: ax,
                          //    physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  
                                      children: [
                                       
                                           Container(
                                                       height:200,
                                                       width: 380,
                                                        child: Image.network(
                                                      '${first + snapshot.data![0].carouselImage.toString()}',
                                                      fit: BoxFit.fill,
                                                                                          )
                                         
                                                                                          
                                                                                          ),

                                                                                          SizedBox(width: 10,),
                                                                                             Container(
                                                     height:190,
                                                        child: Image.network(
                                                      '${first + snapshot.data![1].carouselImage.toString()}',
                                                      fit: BoxFit.fill,
                                                                                          )
                                  
                                                                                          
                                                                                          ),
                                                                                           SizedBox(width: 10,),
                                                                                             Container(
                                                    height:190,
                                                        child: Image.network(
                                                      '${first + snapshot.data![2].carouselImage.toString()}',
                                                      fit: BoxFit.fill,
                                                                                          )
                                  
                                                                                          
                                                                                          ),
                                                                                           SizedBox(width: 10,),
                                                                                             Container(
                                                      height:190,
                                                        child: Image.network(
                                                      '${first + snapshot.data![3].carouselImage.toString()}',
                                                      fit: BoxFit.fill,
                                                                                          )
                                  
                                                                                          
                                                                                          ),
                                                                                           SizedBox(width: 10,),
                                                                                             Container(
                                                     height:190,
                                                        child: Image.network(
                                                      '${first + snapshot.data![4].carouselImage.toString()}',
                                                      fit: BoxFit.fill,
                                                                                          )
                                  
                                                                                          
                                                                                          ),
                                            //                                                 SizedBox(width: 10,),
                                            //                                               Container(
                                            //       height:190,
                                            //             child: Image.network(
                                            //           '${first + snapshot.data![5].carouselImage.toString()}',
                                            //           fit: BoxFit.fill,
                                            //                                               )
                                  
                                                                                          
                                            //                                               ),
                                            //                                                 SizedBox(width: 10,),
                                            //                                               Container(
                                            //  height:190,
                                            //             child: Image.network(
                                            //           '${first + snapshot.data![6].carouselImage.toString()}',
                                            //           fit: BoxFit.fill,
                                            //                                               )
                                  
                                                                                          
                                            //                                               ),
                                            //                                                 SizedBox(width: 10,),
                                            //                                               Container(
                                            //      height:190,
                                            //             child: Image.network(
                                            //           '${first + snapshot.data![7].carouselImage.toString()}',
                                            //           fit: BoxFit.fill,
                                            //                                               )
                                  
                                                                                          
                                            //                                               ),
                                                                                          
                                            
                                                                                     
                                           
                                      ],
                                    ),
                                  ),
                                );
                              });
                                             } else {
                          return Center(
                            child: LoadingIndicator(
    indicatorType: Indicator. ballSpinFadeLoader, /// Required, The loading type of the widget
    colors: const [Colors.blue],       /// Optional, The color collections
    strokeWidth: 1,                     /// Optional, The stroke of the line, only applicable to widget which contains line
    backgroundColor: Colors.white,      /// Optional, Background of the widget
    pathBackgroundColor: Colors.red   /// Optional, the stroke backgroundColor
)
                          );
                                             }
                                           }),
                                           

  //             ],options: CarouselOptions(
  //     height: 100,
      
    
  //     aspectRatio: 16/9,
  //     viewportFraction: 0.8,
  //     initialPage: 0,
  //     enableInfiniteScroll: true,
  //     reverse: false,
  //     //autoPlay: true,
  //     autoPlayInterval: Duration(seconds: 3),
  //     autoPlayAnimationDuration: Duration(milliseconds: 800),
  //     autoPlayCurve: Curves.fastOutSlowIn,
  //     enlargeCenterPage: true,
  //     //onPageChanged: callbackFunction,
  //     scrollDirection: Axis.horizontal,
      
  //  ),
  //          ),  
           
              Container(
                 height: 280,
                 color: Color.fromARGB(255, 1, 11, 66),
                
                 child: Column(
                   

                   children: [
                         SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text("    Opening Hours",style: TextStyle(fontSize: 22, color: Colors.white),),
                                ],
                              ),
                              SizedBox(height: 20,),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                           Text("Mon - Wed",style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text("10:00am - 7:00pm",style: TextStyle(fontSize: 18, color: Colors.white),)
                              ],),
                                SizedBox(height: 18,),
                               Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                           Text("Thursday",style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text(" 10:00am - 4:00pm",style: TextStyle(fontSize: 18, color: Colors.white),)
                              ],),
                             SizedBox(height: 18,),
                                 Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                           Text("Sat - Sun",style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text(" 10:00am - 7:00pm",style: TextStyle(fontSize: 18, color: Colors.white),)
                              ],),
                              SizedBox(height: 18,),
                              
                            Padding(
                              padding: const EdgeInsets.only(left: 28,right:28),
                              child: SizedBox(height:50,
                              child: Card(
                                elevation:3,
                                color: Colors.white,
                              child:  Row( mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text("Appointment",style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 11, 66), fontWeight: FontWeight.bold),)
                              ],)
                              ),
                              ),
                            ),
                       SizedBox(height: 10,),
                   ],
                 ),

               ),
             
              
                Container(
                 height: 280,
                 color:Color.fromARGB(255, 139, 100, 100),
                
                 child: Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Column(
                     
                        mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                           SizedBox(height: 18,),
                               Column(children: [
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                  
                                  children: [
                                    Text("Make Appointment",style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold), ),
                                  ],
                                ),
                                SizedBox(height: 18,),
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                             Text("Ipsum erat ipsum dolor clita rebum no\n rebum dolores labore, ipsum magna\n at eos et eos amet.",style: TextStyle(fontSize: 18, color: Colors.white),),
                            
                                ],),
                                  SizedBox(height: 18,),
                                 Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                             Text("+962 795258121",style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
                           
                                ],),
                               ],),
                             
                               
                                
                           
                         SizedBox(height: 10,),
                     ],
                   ),
                 ),

               ),
             
         SizedBox(height: 6,),
 
              
                         FutureBuilder<before_after>(
                  future: beforeafter(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      var first = 'http://drhibasaadeh.com';

                      //  var second=snapshot.data!.beforeImage.toString();
                      //  var image=first+second;
                      print('image');
                      return ListView.builder(
                          shrinkWrap: true,
                          // scrollDirection: ax,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child:  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [

                                        // CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.beforeImage![index].toString()),),
                                        // SizedBox(height: 10,),
                                       Row(children: [
                                          Expanded(
                                            child: Container(
                                              height:180,
                                              child: Image.network(
                                            '${first + snapshot.data!.beforeImage.toString()}',
                                            fit: BoxFit.fill,
                                                                                )
                                                                                ),
                                          ),
                                          SizedBox(width: 5,),
                                         Expanded(
                                           child: Container(
                                              height:180,
                                              child: Image.network(
                                            '${first + snapshot.data!.afterImage.toString()}',
                                            fit: BoxFit.fill,
                                                                               )
                                                                               ),
                                         ),
                                       ],),

                                        // SizedBox(
                                        //   height: 25,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                            
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                        
                        children: [
                        Text("We Offer The Best Quality\n Dental Services ", style: TextStyle(fontSize: 22 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),
                 ),
                FutureBuilder(
                  future: servicesfunction(),
                  builder: (context,AsyncSnapshot<List<services>> snapshot) {
                    if (snapshot.data != null) {
                      var first = 'http://drhibasaadeh.com';

                      //  var second=snapshot.data!.beforeImage.toString();
                      //  var image=first+second;
                      print('image');
                      return ListView.builder(
                          shrinkWrap: true,
                          // scrollDirection: ax,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:  1,    //photoList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [

                                    // CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.beforeImage![index].toString()),),
                                    // SizedBox(height: 10,),
                                  
                              
                                       
                                           Container(
                                               width: double.infinity,
                                              height:180,
                                              child: Image.network(
                                                                                         '${first + snapshot.data![0].serviceImage.toString()}',
                                                                                         fit: BoxFit.fill,
                                                                                )
                                                                                ),
                                           
                      
                   SizedBox(
                     height: 60,
                     child: Container(
                       color:  HexColor("#EEF9FF"),
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Cosmetic Dentistry ", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),),
                   ),
                   SizedBox(height: 20,),
                
                  Container(
                    width: double.infinity,
                   height:180,
                   child: Image.network(
                                                              '${first + snapshot.data![1].serviceImage.toString()}',
                                                              fit: BoxFit.fill,
                                                     )
                                                     ),
                                            SizedBox(
                     height: 60,
                     child: Container(
                       color:  HexColor("#EEF9FF"),
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Dental Implants", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),),
                   ),
                                            
                                          SizedBox(height: 20,),
                
                                      Container(
                                        width: double.infinity,
                                       height:180,
                                       child: Image.network(
                                                                                  '${first + snapshot.data![2].serviceImage.toString()}',
                                                                                  fit: BoxFit.fill,
                                                                         )
                                                                         ),
                                                                            SizedBox(
                     height: 60,
                     child: Container(
                       color:  HexColor("#EEF9FF"),
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Dental Bridges", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),),
                   ),
                                    SizedBox(height: 20,),
                
                         Container(
                           width: double.infinity,
                          height:180,
                          child: Image.network(
                                                                     '${first + snapshot.data![3].serviceImage.toString()}',
                                                                     fit: BoxFit.fill,
                                                            )
                                                            ),
                                           SizedBox(
                     height: 60,
                     child: Container(
                       color:  HexColor("#EEF9FF"),
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Teeth Whitening", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),),
                   ),
                                                 SizedBox(height: 20,),
                 Container(
                                                  width: double.infinity,
                                                 height:180,
                                                 child: Image.network(
                                                                                            '${first + snapshot.data![4].serviceImage.toString()}',
                                                                                            fit: BoxFit.fill,
                                                                                   )
                                                                                   ),
                                             SizedBox(
                     height: 60,
                     child: Container(
                       color:  HexColor("#EEF9FF"),
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Root Canal Treatment", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),),
                   ),
                                             

                                    // SizedBox(
                                    //   height: 25,
                                    // ),
                                  ],
                                ),
                                ),
                            
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                   SizedBox(height: 30,),
                    Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
                Row(
                        
                        children: [
                        Text("PRICING PLAN", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),
                         SizedBox(height: 10,),
                    Row(
                        
                        children: [
                        Text("We Offer Fair Prices for\nDental Treatment ", style: TextStyle(fontSize: 23 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),
                      SizedBox(height: 10,),
                        Row(
                        
                        children: [
                        Text("CALL FOR APPOINTMENT", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),
                         Row(
                        
                        children: [
                        Text("+962 795258121", style: TextStyle(fontSize: 23 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                      ],),
                      
            ],),
          ),
                  SizedBox(height: 30,),
                      CarouselSlider(
           items: [   ListView(children: [Stack(
               clipBehavior: Clip.none,
                     
             children: [
            
                       Container(
              height: 580,
              width: double.infinity,
              color:  Color.fromARGB(255, 201, 219, 233),
               child:Column(children: [
                  Container(
                     height: 290,
                 width: double.infinity,
                                  child: Image.network("http://drhibasaadeh.com/media/serviceImg/CosmeticDen.jpg",fit: BoxFit.fill,),
               ),
               SizedBox(height: 45,),
                   Text("Cosmetic Dentistry", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                   Padding(
                     padding: const EdgeInsets.only(left: 110,right: 110),
                     child: Divider(thickness: 1,color:  Color.fromARGB(255, 1, 11, 66),),
                   ),
               ListTile(
           
                 title: Text("Modern Equipment ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               ),
                 ListTile(
           
                 title: Text("Proffessional Dentist ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               ),
                ListTile(
           
                 title: Text("24/7 Call Support ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               )
                  
               ],)
                   
                     
           ),
             Positioned(
            right: 90,
            
            bottom: 265,
            child:  Card(
            color:  Color.fromARGB(255, 201, 219, 233),
                                 //  elevation: 5,
                                    child: Container(
             height: 50,
             width: 100,
             child:   Center(child: Text("\$200", style: TextStyle(fontSize: 21 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), )),
                                    ),
                                  ),
                ),
                  Positioned(
            right: 60,
            
            top: 545,
            child:  Card( color: Color.fromARGB(255, 1, 11, 66),                         //  elevation: 5,
                                    child: Container(
             height: 50,
             width: 150,
             child:   Center(child: Text("Appointment", style: TextStyle(fontSize: 18 , color: Colors.white ,fontWeight: FontWeight.bold,), )),
                                    ),
                                  ),
                )
              
           ],
           ),],),
           //
           ListView(children: [Stack(
               clipBehavior: Clip.none,
                     
             children: [
            
                       Container(
              height: 580,
              width: double.infinity,
              color:  Color.fromARGB(255, 201, 219, 233),
               child:Column(children: [
                  Container(
                     height: 290,
                 width: double.infinity,
                                  child: Image.network("http://drhibasaadeh.com/media/serviceImg/dental_implant.jpg",fit: BoxFit.fill,),
               ),
               SizedBox(height: 45,),
                   Text("Dental Implants", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                   Padding(
                     padding: const EdgeInsets.only(left: 110,right: 110),
                     child: Divider(thickness: 1,color:  Color.fromARGB(255, 1, 11, 66),),
                   ),
               ListTile(
           
                 title: Text("Modern Equipment ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               ),
                 ListTile(
           
                 title: Text("Proffessional Dentist ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               ),
                ListTile(
           
                 title: Text("24/7 Call Support ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                 trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
               )
                  
               ],)
                   
                     
           ),
             Positioned(
            right: 90,
            
           bottom: 265,
            child:  Card(
            color:  Color.fromARGB(255, 201, 219, 233),
                                 //  elevation: 5,
                                    child: Container(
             height: 50,
             width: 100,
             child:   Center(child: Text("\$90", style: TextStyle(fontSize: 21 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), )),
                                    ),
                                  ),
                ),
                  Positioned(
            right: 60,
            
            top: 545,
            child:  Card( color: Color.fromARGB(255, 1, 11, 66),                         //  elevation: 5,
                                    child: Container(
             height: 50,
             width: 150,
             child:   Center(child: Text("Appointment", style: TextStyle(fontSize: 18 , color: Colors.white ,fontWeight: FontWeight.bold,), )),
                                    ),
                                  ),
                )
              
           ],)],),
            ListView(children: [Stack(
                 clipBehavior: Clip.none,
                       
               children: [
              
                         Container(
                height: 580,
                width: double.infinity,
                color:  Color.fromARGB(255, 201, 219, 233),
                 child:Column(children: [
                    Container(
                       height: 290,
                   width: double.infinity,
                                    child: Image.network("http://drhibasaadeh.com/media/serviceImg/service-3_h0gXNnD.jpg",fit: BoxFit.fill,),
                 ),
                 SizedBox(height: 45,),
                     Text("Dental Bridges", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                     Padding(
                       padding: const EdgeInsets.only(left: 110,right: 110),
                       child: Divider(thickness: 1,color:  Color.fromARGB(255, 1, 11, 66),),
                     ),
                 ListTile(
             
                   title: Text("Modern Equipment ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                   ListTile(
             
                   title: Text("Proffessional Dentist ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                  ListTile(
             
                   title: Text("24/7 Call Support ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 )
                    
                 ],)
                     
                       
             ),
               Positioned(
              right: 90,
              
             bottom: 265,
              child:  Card(
              color:  Color.fromARGB(255, 201, 219, 233),
                                   //  elevation: 5,
                                      child: Container(
               height: 50,
               width: 100,
               child:   Center(child: Text("\$200", style: TextStyle(fontSize: 21 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  ),
                    Positioned(
              right: 60,
              
              top: 545,
              child:  Card( color: Color.fromARGB(255, 1, 11, 66),                         //  elevation: 5,
                                      child: Container(
               height: 50,
               width: 150,
               child:   Center(child: Text("Appointment", style: TextStyle(fontSize: 18 , color: Colors.white ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  )
                
             ],)],),
               ListView(children: [Stack(
                 clipBehavior: Clip.none,
                       
               children: [
              
                         Container(
                height: 580,
                width: double.infinity,
                color:  Color.fromARGB(255, 201, 219, 233),
                 child:Column(children: [
                    Container(
                       height: 290,
                   width: double.infinity,
                                    child: Image.network("http://drhibasaadeh.com/media/serviceImg/Teeth_White.jpg",fit: BoxFit.fill,),
                 ),
                 SizedBox(height: 45,),
                     Text("Teeth Whitening", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                     Padding(
                       padding: const EdgeInsets.only(left: 110,right: 110),
                       child: Divider(thickness: 1,color:  Color.fromARGB(255, 1, 11, 66),),
                     ),
                 ListTile(
             
                   title: Text("Modern Equipment ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                   ListTile(
             
                   title: Text("Proffessional Dentist ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                  ListTile(
             
                   title: Text("24/7 Call Support ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 )
                    
                 ],)
                     
                       
             ),
               Positioned(
              right: 90,
              
            bottom: 265,
              child:  Card(
              color:  Color.fromARGB(255, 201, 219, 233),
                                   //  elevation: 5,
                                      child: Container(
               height: 60,
               width: 100,
               child:   Center(child: Text("\$40", style: TextStyle(fontSize: 21 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  ),
                    Positioned(
              right: 80,
              
              top: 545,
              child:  Card( color: Color.fromARGB(255, 1, 11, 66),                         //  elevation: 5,
                                      child: Container(
               height: 50,
               width: 150,
               child:   Center(child: Text("Appointment", style: TextStyle(fontSize: 18 , color: Colors.white ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  )
                
             ],)],),
             ListView(children: [Stack(
                 clipBehavior: Clip.none,
                       
               children: [
              
                         Container(
                height: 580,
                width: double.infinity,
                color:  Color.fromARGB(255, 201, 219, 233),
                 child:Column(children: [
                    Container(
                       height: 290,
                   width: double.infinity,
                                    child: Image.network("http://drhibasaadeh.com/media/serviceImg/rootcanal.jpg",fit: BoxFit.fill,),
                 ),
                 SizedBox(height: 45,),
                     Text("Root Canal Treatment", style: TextStyle(fontSize: 20 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), ),
                     Padding(
                       padding: const EdgeInsets.only(left: 110,right: 110),
                       child: Divider(thickness: 1,color:  Color.fromARGB(255, 1, 11, 66),),
                     ),
                 ListTile(
             
                   title: Text("Modern Equipment ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                   ListTile(
             
                   title: Text("Proffessional Dentist ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 ),
                  ListTile(
             
                   title: Text("24/7 Call Support ", style: TextStyle(fontSize: 18 , color:  Color.fromARGB(255, 1, 11, 66)), ),
                   trailing: Icon(Icons.done, size: 28,color:  Color.fromARGB(255, 1, 11, 66)),
                 )
                    
                 ],)
                     
                       
             ),
               Positioned(
              right: 90,
           bottom: 265,
              child:  Card(
              color:  Color.fromARGB(255, 201, 219, 233),
                                   //  elevation: 5,
                                      child: Container(
               height: 50,
               width: 100,
               child:   Center(child: Text("\$100", style: TextStyle(fontSize: 21 , color:  Color.fromARGB(255, 1, 11, 66) ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  ),
                    Positioned(
              right: 80,
              
              top: 545,
              child:  Card( color: Color.fromARGB(255, 1, 11, 66),                         //  elevation: 5,
                                      child: Container(
               height: 60,
               width: 150,
               child:   Center(child: Text("Appointment", style: TextStyle(fontSize: 18 , color: Colors.white ,fontWeight: FontWeight.bold,), )),
                                      ),
                                    ),
                  )
                
             ],)],)



             ],options: CarouselOptions(
              height: 600,
              
              
            
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
              
           ),
         ),
          SizedBox(height: 30,),
               //feedback
               
              CarouselSlider(
                items: [
                 
                        Container(
                                                   width: double.infinity,
                                                   height: 250,
                                                   child: Card(
                                                             shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                                                     color: Color.fromARGB(255, 1, 11, 66),
                                                     
                                                                                               
                                                      child:Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                          SizedBox(height: 6,),
                                                         Row(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: [
                                                             Text("I can/t thank Dr Hiba Saadeh\nenough. She is very professional\nunderstanding, caring and a delight\nto visit",style: TextStyle(fontSize: 15, color: Colors.white),
                                                    ),
                                                    
                                                            
                                                         ],),
                                                    //       Row(
                                                    //        mainAxisAlignment: MainAxisAlignment.center,
                                                    //        children: [
                                                    //          Text("enough. She is very professional,",style: TextStyle(fontSize: 15, color: Colors.white),
                                                    // ),
                                                    
                                                            
                                                    //      ],),
                                                    //       Row(
                                                    //        mainAxisAlignment: MainAxisAlignment.center,
                                                    //        children: [
                                                    //          Text("understanding, caring and a delight\n   to visit",style: TextStyle(fontSize: 15, color: Colors.white),
                                                    // ),
                                                    
                                                            
                                                        //  ],),
                                                          SizedBox(height: 4,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 65,right: 65),
                                                          child: Divider(thickness: 2,color: Colors.grey,),
                                                        ),
                                                           SizedBox(height: 14,),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Column(children: [
                                                                 Text("Shavej Shaikh",style: TextStyle(fontSize: 16, color: Colors.white),),
                                                              ],),
                                                            ),
                                                            SizedBox(height: 10,),
                                                        ],),
                                                      )
                                                      
                                                    
                                                   ),
                                                   
                                                 ),
                                                   Container(
                                                   width: double.infinity,
                                                   height: 250,
                                                   child: Card(
                                                             shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                                                     color: Color.fromARGB(255, 1, 11, 66),
                                                     
                                                                                               
                                                      child:Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                        SizedBox(height: 6,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text("She is very professional\ntowards her work.",style: TextStyle(fontSize: 18, color: Colors.white),
                                                    ),
                                                          
                                                       ],),
                                                        SizedBox(height: 4,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 65,right: 65),
                                                        child: Divider(thickness: 2,color: Colors.grey,),
                                                      ),
                                                         SizedBox(height: 14,),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(children: [
                                                               Text("Tarteel Burza",style: TextStyle(fontSize: 16, color: Colors.white),),
                                                            ],),
                                                          ),
                                                          SizedBox(height: 10,),
                                                      ],)
                                                      
                                                    
                                                   ),
                                                   
                                               
                 
                    ),
                    Container(
                                                   width: double.infinity,
                                                   height: 250,
                                                   child: Card(
                                                             shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                                                     color: Color.fromARGB(255, 1, 11, 66),
                                                     
                                                                                               
                                                      child:Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                        SizedBox(height: 6,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text("Good",style: TextStyle(fontSize: 18, color: Colors.white),
                                                    ),
                                                          
                                                       ],),
                                                        SizedBox(height: 4,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 65,right: 65),
                                                        child: Divider(thickness: 2,color: Colors.grey,),
                                                      ),
                                                         SizedBox(height: 14,),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(children: [
                                                               Text("Meher Bilal",style: TextStyle(fontSize: 16, color: Colors.white),),
                                                            ],),
                                                          ),
                                                          SizedBox(height: 10,),
                                                      ],)
                                                      
                                                    
                                                   ),
                                                   
                                               
                 
                    ),
                     Container(
                                                   width: double.infinity,
                                                   height: 250,
                                                   child: Card(
                                                             shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                                                     color: Color.fromARGB(255, 1, 11, 66),
                                                     
                                                                                               
                                                      child:Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                        SizedBox(height: 6,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text("Nice Clinic",style: TextStyle(fontSize: 18, color: Colors.white),
                                                    ),
                                                          
                                                       ],),
                                                        SizedBox(height: 4,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 65,right: 65),
                                                        child: Divider(thickness: 2,color: Colors.grey,),
                                                      ),
                                                         SizedBox(height: 14,),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(children: [
                                                               Text("Test_A Test_A",style: TextStyle(fontSize: 16, color: Colors.white),),
                                                            ],),
                                                          ),
                                                          SizedBox(height: 10,),
                                                      ],)
                                                      
                                                    
                                                   ),
                                                   
                                               
                 
                    )
                                               
                                           
                                               
                                           

                 

                               ],options: CarouselOptions(
      height: 210,
      
      
    
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      //onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
      
   ),
           ),


                //  FutureBuilder(
                //   future: feedbackfunnction(),
                //   builder: (context,AsyncSnapshot<List<fedback_model>> snapshot) {
                //     if (snapshot.data != null) {
                //       var first = 'http://drhibasaadeh.com';

                //       //  var second=snapshot.data!.beforeImage.toString();
                //       //  var image=first+second;
                //       print('Feedback');
                //       return ListView.builder(
                //           shrinkWrap: true,
                //           // scrollDirection: ax,
                //           physics: NeverScrollableScrollPhysics(),
                //           itemCount:  1,    //photoList.length,
                //           itemBuilder: (context, index) {
                //             return Padding(
                //                 padding: const EdgeInsets.all(8),
                //                 child: Column(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.center,
                //                   children: [

                //                     // CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.beforeImage![index].toString()),),
                //                     // SizedBox(height: 10,),
                                  
                            
                                       
                                         
                                             
                //                                  Container(
                //                                    width: double.infinity,
                //                                    height: 190,
                //                                    child: Card(
                //                                              shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(12),
                // ),
                //                                      color: Color.fromARGB(255, 1, 11, 66),
                                                     
                                                                                               
                //                                       child:Column(
                //                                         mainAxisAlignment: MainAxisAlignment.center,
                //                                         children: [
                //                                         SizedBox(height: 6,),
                //                                        Row(
                //                                          mainAxisAlignment: MainAxisAlignment.center,
                //                                          children: [
                //                                            Text(snapshot.data![0].firstName.toString(),style: TextStyle(fontSize: 18, color: Colors.white),
                //                                     ),
                //                                            SizedBox(width: 4,),
                //                                            Text(snapshot.data![0].lastName.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                //                                        ],),
                //                                         SizedBox(height: 4,),
                //                                       Padding(
                //                                         padding: const EdgeInsets.only(left: 65,right: 65),
                //                                         child: Divider(thickness: 2,color: Colors.grey,),
                //                                       ),
                //                                          SizedBox(height: 14,),
                //                                           Padding(
                //                                             padding: const EdgeInsets.all(8.0),
                //                                             child: Column(children: [
                //                                                Text(snapshot.data![0].description.toString(),style: TextStyle(fontSize: 16, color: Colors.white),),
                //                                             ],),
                //                                           ),
                //                                           SizedBox(height: 10,),
                //                                       ],)
                                                      
                                                    
                //                                    ),
                                                   
                //                                  ),
                                               
                                           
                                      
                                    
                                

                //                     // SizedBox(
                //                     //   height: 25,
                //                     // ),
                //                   ],
                //                 ),
                //               );
                //           });
                //     } else {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   }),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
    //  ),
    );
  }
}
