import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //the time in that location
  late String flag; // url to an asset flag icon
  late String url;//location url for api endpoint
  late bool isDaytime;//true or false if daytime or not

  WorldTime({ required this.location,  required this.flag,
    required this.url}); //location url for api endpoint


  Future<void> getTime() async{

    try {
      //make the request
      var link = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      var response = await http.get(link);
      Map data = jsonDecode(response.body);

      //get propeties from data

      String datetime = data['datetime'];
      //print('Datetime is  $datetime');
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);

      //Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));



      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20  ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Cauth error $e');
      time = 'could not get time data';
    }
  }
}

