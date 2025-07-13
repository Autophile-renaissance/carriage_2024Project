import 'dart:convert';

import 'package:carriage_app/allScreens/cost.dart';
import 'package:carriage_app/allScreens/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupTextEditingController= TextEditingController();
  TextEditingController dropOffTextEditingController= TextEditingController();
  var uuid =const Uuid();
  final String token='1234567890';
  List<dynamic> listOfLocation=[];
  List location=['Nyamavilla', 'Kitusuru','Kangemi', 'Moi Avenue', 'Kenyatta avenue', 'Ronald Ngala', 'Tom Mboya'];
  

@override
   void initState() {
    dropOffTextEditingController.addListener((){});
    // TODO: implement initState
    super.initState();
  }
  _onChange(){
    placeSuggestion(dropOffTextEditingController.text);
  }
   void placeSuggestion(String input) async{
      const String apiKey="AIzaSyAla7c_rE9yLOP7tSvuuJs09DaCx9XkgUE";
      try{
        String bassedUrl ="https://maps.googleapis.com/maps/api/place/autocomplete/json";
        String request='$bassedUrl?inpute=$input&key=$apiKey&sessiontoken=$token';
        var response= await http.get(Uri.parse(request));
        var data=json.decode(response.body);
        if(kDebugMode){
          print(data);
        }
        if(response.statusCode==200)
{
  setState(() {
    listOfLocation=json.decode(response.body)['predictions'];

  });
} 
else{}{
  throw Exception("Fail to load");
}


     }catch(e){
      print(e.toString());
     }
   }

  @override
  Widget build(BuildContext context) {

    //capture the data on what is your actual geolocation name
    return Scaffold(
 body:Padding(
   padding: const EdgeInsets.all(15.0),
   child: Column(
            children: [
              TextField(
                controller: dropOffTextEditingController,
                decoration: InputDecoration(
                  hintText: "Search Place",
                   
                ),
                onSubmitted: (value){
                  CostScreen();
                }
                
              ),
              Visibility(
                visible: dropOffTextEditingController.text.isEmpty ? false : true,
                child: Expanded(child: 
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      if(index >=0 && index<listOfLocation.length){
                    return GestureDetector(
                      child: Text(location[index]),
                    );}
                      return null;
                  },),
                ),),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CostScreen()));
              }, child: Text('Get Logistics'))
             
            ],
           ),
 )    




    /* body: Column(children: [
Container(
  height: 215.0,
  decoration: BoxDecoration(
 color: Colors.white,
 boxShadow: [
  BoxShadow(
    color: Colors.black,
    blurRadius: 6.0,
    spreadRadius: 0.5,
    offset: Offset(0.7, 0.7),
  )
 ]



  ),
  child: Padding(padding: EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0,bottom: 20.0 ),
    child: Column(
      children: [
        SizedBox(
          height: 5.0,
        ),
        /*Stack(
          children: [
            GestureDetector
            
            (
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainScreen()));
              },
              child: Icon(Icons.arrow_back)),
            Center(
              child: Text("Set Drop Off", style: TextStyle(fontSize: 18.0 ),),
            )
          ],
        ),*/
        SizedBox( width: 18.0, height: 20.0,),
        /*Row(
          children: [
            Image.asset('images/pickicon.png', height: 16.0,width: 16.0,),
            SizedBox( width: 18.0,),

            Expanded(child: Container(

              decoration: BoxDecoration(

                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5.0),
                
              ),
              child: Padding(padding: EdgeInsets.all(3.0),
              child: TextField(
                controller: pickupTextEditingController,
                decoration: InputDecoration(
                  hintText: "Pickup Location",
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.only(left: 11.0 , top: 8.0 , bottom: 8.0),
                ),


              ),),
            ))
          ],
        ),*/

        SizedBox( width: 18.0, height: 20.0,),
       /* Row(
          children: [
            Image.asset('images/pickicon.png', height: 16.0,width: 16.0,),
            SizedBox( width: 18.0,),

            Expanded(child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                    
                  ),
                  child: TextField(
                  controller: dropOffTextEditingController,
                  onChanged: (value){
                 setState(() {
                   
                 });
                  },
                 
                  decoration: InputDecoration(
                    hintText: "DropOff Location",
                    fillColor: Colors.grey[400],
                    filled: true,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 11.0 , top: 8.0 , bottom: 8.0),
                  ),
                
                
                ),
                ),
                Expanded(child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,

                  itemBuilder:(context , index){
                  return GestureDetector(
                    onTap:(){},
                    child: Text(listOfLocation[index]["description"]),
                  );
                }))
              ],
            ))
          ],
        )*/
        

      ],
    ),
  ),
)

     ],),
    );*/
    );}
}