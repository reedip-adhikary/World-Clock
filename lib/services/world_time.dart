import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for ui
  late String time; //time in location
  late String flag; // url to asset flag
  late String url; //location url for api endpoints
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      //make request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data =jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1,3);
      String offset2 = data['utc_offset'].substring(4,6);
      // print(datetime);
      // print(offset1);
      // print(offset2);

      //create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1),minutes: int.parse(offset2)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }

  }

}