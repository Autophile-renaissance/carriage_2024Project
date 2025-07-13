import 'dart:async';
import 'package:carriage_app/Models/state.dart';
import 'package:carriage_app/allScreens/location.dart';
import 'package:carriage_app/allScreens/search_screen.dart';
import 'package:carriage_app/allWidgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

 
class CostScreen extends StatefulWidget {
 CostScreen({super.key});
static const String idScreen = "main";
 static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<CostScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<CostScreen> {
 GlobalKey<ScaffoldState> scaffoldKey=  GlobalKey<ScaffoldState>();

late GoogleMapController newGoogleMapController;

late Position currentPosition;

var  geolocator =Geolocator();

double bottomPaddingMap=0.0;

double searchTransport=340.0;

double rideDetailsContainer=0;


void displayRiderDetails()async{
  setState(() {
    searchTransport=0;
    rideDetailsContainer=0.0;
    bottomPaddingMap=230.0;
  });
}



void locatePosition() async{
 
Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
currentPosition=position;

LatLng latLatPosition=LatLng(position.latitude, position.longitude);
CameraPosition cameraPosition =  CameraPosition(target: latLatPosition, zoom: 14.0);
newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition)); 
}

final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
     

    drawer: Container(
      color: Colors.white,
      width: 255.0,
      child: Drawer(child: ListView(children: [
       Container(
        height: 165.0,
        child: DrawerHeader(child: Row(
          children: [
            Image.asset("images/user_icon.png" , height: 65.0, width: 65.0,),
            SizedBox(width: 16.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Profile Name" ,style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Brand Bold",
                ),),
                SizedBox(height: 6.0,),
                Text("Visit Profile"),
              ],
            )
            
            ],
        ),
        decoration: BoxDecoration(color: Colors.white),),
       ),
        DividerWidget(),

        SizedBox(height: 12.0,),

        ListTile(
          leading: Icon(Icons.history),
          title: Text("History" , style: TextStyle(fontSize: 15.0),),

        ),
         ListTile(
          leading: Icon(Icons.person),
          title: Text("Visit Profile" , style: TextStyle(fontSize: 15.0),),

        ),
         ListTile(
          leading: Icon(Icons.info),
          title: Text("About" , style: TextStyle(fontSize: 15.0),),

        ),
        


      ],),),
    ),


      body: Stack(
        children: [
        /*GoogleMap(mapType: MapType.normal,
        padding: EdgeInsets.only(bottom: bottomPaddingMap),
        myLocationButtonEnabled: true,
        initialCameraPosition:_kGooglePlex ,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
         
   _controllerGoogleMap.complete(controller);
   newGoogleMapController=controller;
   
   locatePosition();
        },),*/
    MapScreen(),

     //hamburger icon 
      Positioned(
        top: 45.0,
        left: 22.0,

        child: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.0),
            boxShadow: [
              BoxShadow(
          color: Colors.black,
          blurRadius: 6.0,
          spreadRadius: 0.5,
          offset: Offset(0.7, 0.7),
              )
            ]
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
            radius: 20.0,
          ),
          
          
          
          ),
        ),
      ),






        Positioned( 
         left: 0.0,
         right: 0.0,
         bottom: 0.0,
        
         
          child: AnimatedSize(
            curve: Curves.bounceIn,
            duration: Duration(microseconds: 160),
            child: Container(
              height: rideDetailsContainer,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ]
               ),
              
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 6.0,        
                  ),
                  Text("Hey There",style: TextStyle(fontSize: 18.0),
                  ),
                  Text("Where to ?",style: TextStyle(fontSize: 20.0 , fontFamily: "Brand Bold"),
                  ),
                  SizedBox(height: 20.0,),
            
                  GestureDetector(
                    onTap: () async{
                     var res= await Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                    if(res=='ObtainDirection'){
                      displayRiderDetails(); //displayed to show the ridedetails when destination has been set  
                    }

                    },
                    child: Container(
                     decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(8.0)),
                                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    )
                                  ]
                                 ),
                    
                                 child: Padding(
                                   padding: const EdgeInsets.all(12.0),
                                   child: Row(
                    children: [
                      Icon(Icons.search , color: Colors.yellowAccent,),
                      SizedBox(width: 10.0,),
                      Text("Search Drop off")
                    ],
                                   ),
                                 ),
                    
                    
                    
                    
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  Row(
                    children: [
                      Icon(Icons.add_location , color: Colors.grey, ),
                      SizedBox( width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text("Address"),
                          SizedBox(height: 4.0,),
                          Text("Your Current Address", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                        ],
                      )
                    ],
                  ),
                  
                  DividerWidget(),
                   
                 /* Row(
                    children: [
                      Icon(Icons.work , color: Colors.grey, ),
                      SizedBox( width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text("Add home"),
                          SizedBox(height: 4.0,),
                          Text("Your Office Address", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                        ],
                      )
                    ],
                  )*/
                 ],),
               ),
            ),
          ),),
          Positioned(child: AnimatedSize(
            duration: Duration(milliseconds: 160),
            curve: Curves.bounceIn,
            child: Container(
              height: searchTransport,
              decoration: BoxDecoration(
              
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),
                ),
                
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ]
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 16.0),
                child: Column(children: [
                 SizedBox(height: 10.0,),
                 Text("Carriages", textAlign: TextAlign.center, ),

                 
                 Container(
                  
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(padding: 
                  EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                   children: [
                       Image.asset('images/handcart.png', height: 70.0, width: 80.0,),
                         SizedBox(width: 25.0,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                               
                                Text(
                                  "HandCart", style: TextStyle( fontSize: 25.0 ),
                                ),
                                SizedBox(width: 50.0,),
                                Text(
                                
                                  "450 ksh", style: TextStyle( fontSize: 18.0 ),
                                ),
                                
                              ],
                            ),
                            
                             Text(
                                  " Weight : 600Kgs", style: TextStyle( fontSize: 15.0 , color: Colors.grey ),
                                ),
                                
                            
                          ],
                
                         ) ,
                        
                        


                
                   ],
                  ),),
                  
                 ),
                 
                  DividerWidget(),

                   Container(
                  
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(padding: 
                  EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                   children: [
                       Image.asset('images/trolley.png', height: 70.0, width: 80.0,),
                         SizedBox(width: 25.0,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                               
                                Text(
                                  "Trolley", style: TextStyle( fontSize: 25.0 ),
                                ),
                                SizedBox(width: 85.0,),
                                Text(
                                
                                  "150 ksh", style: TextStyle( fontSize: 18.0 ),
                                ),
                                
                              ],
                            ),
                            
                             Text(
                                  " Weight : 50Kgs", style: TextStyle( fontSize: 15.0 , color: Colors.grey ),
                                ),
                                
                            
                          ],
                
                         ) ,
                        
                        


                
                   ],
                  ),),
                  
                 ),
                 SizedBox(height: 10.0,),
                  DividerWidget(),

                   Container(
                  
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(padding: 
                  EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                   children: [
                       Image.asset('images/porter2.png', height: 70.0, width: 80.0,),
                         SizedBox(width: 35.0,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                               
                                Text(
                                  "Porter", style: TextStyle( fontSize: 25.0 ),
                                ),
                                SizedBox(width: 85.0,),
                                Text(
                                
                                  "50 ksh", style: TextStyle( fontSize: 18.0 ),
                                ),
                                
                              ],
                            ),
                            
                             Text(
                                  " Weight : 30Kgs", style: TextStyle( fontSize: 15.0 , color: Colors.grey ),
                                ),
                                
                            
                          ],
                
                         ) ,
                        
                        


                
                   ],
                  ),),
                  
                 ),
                 SizedBox(height: 10.0,),
                  DividerWidget(),
                
                ],),
              ),
            ),
          ),
          bottom: 0.0,
          left: 0.0,
          right: 0.0,),
          
        ],),
    );
  }
}
