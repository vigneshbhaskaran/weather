
class WeatherModel
{
  
  late Location location;
  late Current current;
  WeatherModel({required this.location,required this.current});
  factory WeatherModel.fromJson(Map<String,dynamic> json)
  {
    return WeatherModel(
     
      location: Location.fromJson(json['location'])      ,
      current: Current.fromJson(json['current'])
      );
  }
}
class Location{
  late double latitude;
  late double longitude;
  late String name;
  late DateTime local;
  Location({required this.latitude,required this.name,required this.longitude,required this.local});
  factory Location.fromJson(Map<String,dynamic> json)
  {
    return Location(
      latitude: (json['lat'] as num).toDouble(),
       name: json['name'],
       longitude:( json['lon'] as num).toDouble(),
       local: DateTime.parse(json['localtime'])
       
       );
  }
}

class Current{
  late double tempc;
  late double wind;
  late Condition condition;
  late double humidity;
  late double cloud;
  Current({required this.tempc,required this.condition,required this.cloud,required this.humidity,required this.wind});
  factory Current.fromJson(Map<String,dynamic> json)
  {
    return Current(
      
      tempc: (json['temp_c'] as num).toDouble(),
      condition:Condition.fromJson( json['condition'])  ,
      humidity: (json['humidity'] as num).toDouble(),
      cloud: (json['cloud'] as num).toDouble(),
      wind:(json['wind_mph'] as num).toDouble(),
      );
  }

}

class Condition{
  late String text;
  late String icon;
  Condition({required this.icon,required this.text});
  factory Condition.fromJson(Map<String,dynamic> json)
  {
    return Condition(
      icon: json['icon'], 
      text: json['text']
      );
  }
}