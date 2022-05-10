import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
final _formKey = GlobalKey<FormState>();
class contact_us extends StatefulWidget {
  const contact_us({ Key? key }) : super(key: key);

  @override
  State<contact_us> createState() => _contact_usState();

 }    
 final String lat = "31.975697";
  final String lng = "35.859400";
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();


  _launchMap() async {
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }
    
  void ContactUs( context ,name,email_id,subject,message) async{

      var headers = {
  'Authorization': 'Bearer 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b',
  'Content-Type': 'application/json',
  'Cookie': 'csrftoken=mck0ryxrOYqV9k2XXIGYpCW2K7sbaN3Yld0iHdAYymUuoSVTWvVzKAommj6Ssrhy; sessionid=w7p7b0gz4rjq7z5tud3x7v7gqvvbwy13'
};
var request = http.Request('POST', Uri.parse('http://drhibasaadeh.com/api/patients/contact/'));
request.body = json.encode({
  "name": name,
  "email_id": email_id,
  "subject": subject,
  "message": message
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 201) {
  print(await response.stream.bytesToString());
  print("Api is Hit");
   final snackBar = SnackBar(
            content: const Text('Message send successfylly'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

      
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
else {
  print(response.reasonPhrase);
    print("Api is Not Hit");
     final snackBar = SnackBar(
            content: const Text('Something went wrong plz try again letter'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

      
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

}

    }

class _contact_usState extends State<contact_us> {
   var name = "";
  var email = "";
  var subject = "";
  var message = "";
    TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
    TextEditingController subjectController = TextEditingController();
     TextEditingController messageController = TextEditingController();
       @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    nameController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
  // #EEF9FF;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
   home: Scaffold( resizeToAvoidBottomInset: false,
      //  backgroundColor:   HexColor("#EEF9FF"),
        // Color.fromARGB(223, 255, 253, 253),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 1, 11, 66),
      //   title: Text("Contact us"),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: ListView(children: [
          SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                   height: 390,
                  
                  
                   child: Card(
                      color: HexColor("#EEF9FF"),
                      elevation: 4,
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Column(
                         
                         
                         children: [
                             
                                   Column(children: [
                                     SizedBox(height: 15,),
                                      Row(
                                      
                                      
                                      children: [
                                        Text("CONTACT US",style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold), ),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                      Row(
                                   
                                      children: [
                                 Text("Feel Free To Contact Us",style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
                                
                                    ],), SizedBox(height: 18,),
                                         GestureDetector(
                                           onTap: () {
                                            
                                                _launchMap();
    
                                           },
                                           child: ListTile(
                                                                        leading:Icon(Icons.place, size: 28,color: Colors.black,) ,
                                                                     
                                                                        title:   Text("Our Office",style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),),
                                                                        subtitle:   Text("Dr. Hiba Saadeh Dental Clinic عيادة الدكتورةهبة سعادة",style: TextStyle(fontSize: 18, color: Colors.black, ),),
                                         
                                         
                                                                           ),
                                         ),
                                     GestureDetector(
                                       onTap: ()async{

                                         String email = 'this.is.nfo@example.com';
    String subject = 'This is a email';
    String body = 'This is a email body';   

    String emailUrl = "mailto:$email?subject=$subject&body=$body";

    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw "Error occured sending an email";
    }

                                       },
                                       child: ListTile(
                                                                    leading:Icon(Icons.email,size: 28,color: Colors.black,) ,
                                                                 
                                                                    title:   Text("Email Us",style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),),
                                                                    subtitle:   Text("info@example.com",style: TextStyle(fontSize: 18, color: Colors.black,),),
                                     
                                     
                                                                       ),
                                     ),
                                       GestureDetector(
                                     onTap: ()async{
                                        String telephoneNumber = '+962 795258121';
                                                                        String telephoneUrl = "tel:$telephoneNumber";

                                                                       if (await canLaunch(telephoneUrl)) {
      await launch(telephoneUrl);
    } else{
       throw "Error occured trying to call that number.";
    }
                                     },
                                         child: ListTile(
                                                                      leading: Icon(Icons.call,size: 28,color: Colors.black,) ,
                                                                      
                                                                      
                                                                      
                                                                     
                                                                      title:   Text("Call Us",style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),),
                                                                      subtitle:   Text("+962 795258121",style: TextStyle(fontSize: 18, color: Colors.black,),),
                                       
                                       
                                                                         ),
                                       )
                                     
                                  
                                       
                                   
                                   ],),
                                 
                                   
                                    
                               
                             SizedBox(height: 10,),
                         ],
                       ),
                     ),
                   ),

                 ),
              ),

                   Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child:  TextFormField(
              //  autocorrect: true,
              
                decoration: InputDecoration(
                  hintText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(),
                    errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                          
                  filled: true,
                  fillColor:  HexColor("#EEF9FF"),
                  enabledBorder: OutlineInputBorder(
                  //  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: HexColor("#EEF9FF"), width: 2),
                   ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:  HexColor("#EEF9FF"), width: 2),
                  ),
                ),
                 controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                
                ),
                
      
                ),
              
                
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child:  TextFormField(
              //  autocorrect: true,
              
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  prefixIcon: Icon(Icons.email),
                  hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(),
                    errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                          
                  filled: true,
                  fillColor:  HexColor("#EEF9FF"),
                  enabledBorder: OutlineInputBorder(
                  //  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: HexColor("#EEF9FF"), width: 2),
                   ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: HexColor("#EEF9FF"), width: 2),
                  ),
                ),
                 controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                
                ),
                
      
                ),
                
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child:  TextFormField(
              //  autocorrect: true,
               
                decoration: InputDecoration(
                  hintText: 'Subject',
                  prefixIcon: Icon(Icons.text_fields),
                  hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(),
                    errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                          
                  filled: true,
                  fillColor:  HexColor("#EEF9FF"),
                  enabledBorder: OutlineInputBorder(
                  //  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: HexColor("#EEF9FF"), width: 2),
                   ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:  HexColor("#EEF9FF"), width: 2),
                  ),
                ),
                controller: subjectController,
                
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter subject';
                        } 
                        return null;
                      },
                
                ),
                
      
                ),
                 Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child:  TextFormField(
              //  autocorrect: true,
               maxLines: 5,
               
                decoration: InputDecoration(
                  hintText: 'Message',
                //  prefixIcon: Icon(Icons.message),
                  hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(),
                    errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                          
                  filled: true,
                  fillColor:  HexColor("#EEF9FF"),
                  enabledBorder: OutlineInputBorder(
                  //  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: HexColor("#EEF9FF"), width: 2),
                   ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:  HexColor("#EEF9FF"), width: 2),
                  ),
                ),
                 controller: messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter message';
                        } 
                        return null;
                      },
                
                ),
                
      
                ),
              
              
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(children: [
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        
                         style: ElevatedButton.styleFrom(
                   primary:  HexColor("#EEF9FF"),
                 ),
                            onPressed: ()   => _openFileExplorer(),
                            child: const Text("Chose file" , style: TextStyle(color: Colors.black,)),
                          ),
                    ),
                    
                 SizedBox(width: 3,),
                          Container(
                            height: 40,
                            width: 230,
                            color:   HexColor("#EEF9FF"),
                            child: Builder(
                                          builder: (BuildContext context) => _loadingPath
                                              ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 8,),
                                  Text("No file chosen"),
                                ],
                              ),
                              //const CircularProgressIndicator(),
                            )
                                              : _directoryPath != null
                              ? ListTile(
                                  title: const Text('Directory path'),
                                  subtitle: Text(_directoryPath!),
                                )
                              : _paths != null
                                  ? Container(
                                      padding: const EdgeInsets.only(bottom: 0.0),
                                      height:
                                          MediaQuery.of(context).size.height * 0.40,
                                      child: Scrollbar(
                                          child: ListView.separated(
                                        itemCount:
                                            _paths != null && _paths!.isNotEmpty
                                                ? _paths!.length
                                                : 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final bool isMultiPath =
                                              _paths != null && _paths!.isNotEmpty;
                                        //  final String name = 'File $index: ' +
                                              (isMultiPath
                                                  ? _paths!
                                                      .map((e) => e.name)
                                                      .toList()[index]
                                                  : _fileName ?? '...');
                                          final path = _paths!
                                              .map((e) => e.path)
                                              .toList()[index]
                                              .toString();
                          
                                          return ListTile(
                                            // title: Text(
                                            //   name,
                                            // ),
                                            subtitle: Text(path),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                      )
                                      ),
                                    )
                                  : const SizedBox(),
                                        ),
                          ),
                      
                        
                     
                 ],),
               ),
                 SizedBox(height: 10,),
                     Column(
                    children: [
                      MaterialButton(
                        color: Color.fromARGB(255, 1, 11, 66),
                        minWidth: double.infinity,
                        height: 50,
                          onPressed: ()  {
                  if (_formKey.currentState!.validate()) {
                                setState(() {
                               email = emailController.text;
                            name = nameController.text;
                            subject = subjectController.text;
                            message = messageController.text;
                                
                                });
                               
                                  

                              
                  
                             
                                  ContactUs(context, nameController.text, emailController.text, subjectController.text, messageController.text);
                              }
          
          },
                       
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.indigo,
                          ),
                         // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Send Message",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,color: Colors.white,
                          ),
      
                        ),
                      ),
                    ],
                ),
                SizedBox(height: 10,),
          
              ],
            ),
          ),
        ),
        ],),
      ),
   )
    );
  }
    void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }
}