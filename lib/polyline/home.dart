import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:carriage_app/polyline/screens/current_location.dart';
import 'package:carriage_app/polyline/screens/nearby_places.dart';
import 'package:carriage_app/polyline/screens/searchplaces.dart';
import 'package:carriage_app/polyline/screens/simplemap.dart';

import 'package:carriage_app/polyline/screens/polyline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const SimpleMapScreen();
              }));
            }, child: const Text("Simple Map")),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const CurrentLocationScreen();
              }));
            }, child: const Text("User current location")),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const SearchPlacesScreen();
              }));
            }, child: const Text("Search Places")),


            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const NearByPlacesScreen();
              }));
            }, child: const Text("Near by Places")),


            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const PolylineScreen();
              }));
            }, child: const Text("Polyline between 2 points"))
          ],
        ),
      ),
    );
  }
}