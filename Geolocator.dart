import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => __LocationWidgetState();
}

class __LocationWidgetState extends State<LocationWidget> {
  Position? position;
  fetchposition()async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled =await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Fluttertoast.showToast(msg: "Location service is disabled");
    }
    permission =await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission =await Geolocator.requestPermission();
      if(permission ==LocationPermission.denied){
        Fluttertoast.showToast(msg: "You denied the permission");
      }
    }
    if(permission == LocationPermission.deniedForever){
      Fluttertoast.showToast(msg: "You denied this permission forever");
    }
    Position currentposition =await Geolocator.getCurrentPosition();
    setState(() {
    position =currentposition ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocation"),
      ),
      body: Column(
        children: [
          Text(position ==null?"Location":position.toString(),style: TextStyle(fontSize: 20,),),
          ElevatedButton(onPressed: (){fetchposition();}, child: Text("Get Location"))
        ],
      ),
    );
  }
}