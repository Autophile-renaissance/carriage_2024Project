import 'package:carriage_app/allScreens/network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  void placeAutocomplete(String query) async{
  Uri uri=Uri.https('maps.googleapis.com',
  'maps/api/place/autocomplete/json',
  {
    "input":query,
    "key":"AIzaSyBuUB4SJQpGAg0_R0b58uOEReRpUJBbecI",
  });
  String? response= await NetworkUtility.fetchUrl(uri);

  if(response!=null){
    
  }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




