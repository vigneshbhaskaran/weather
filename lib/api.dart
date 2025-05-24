import 'dart:convert';
import 'dart:async';     // For TimeoutException
import 'dart:io';    
import 'package:http/http.dart' as http;
import 'package:weather/weatherclass.dart';

class Apiservice{

  Future<WeatherModel> fetchrep(String s) async{
      final url='https://api.weatherapi.com/v1/current.json?key=f0b33b8a9ddd4f5f8df43929251905&q=$s';
      try
      {
    final response=await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

   if(response.statusCode==200)
   {
      final body= jsonDecode(response.body);
      WeatherModel wm=WeatherModel.fromJson(body);
     
     return wm;  
   }
   else if (response.statusCode == 400 || response.statusCode == 404) {
    throw Exception('Location $s not found. Please enter a valid location.');
  }
  else 
   {
        throw Exception('Server error: ${response.statusCode}');
      }
  
      }
on SocketException {
      throw Exception('No Internet connection. Please check your network.');
    } on FormatException {
      throw Exception('Invalid response format. Please try again later.');
    } on http.ClientException {
      throw Exception('Failed to connect to the server.');
    } on TimeoutException {
      throw Exception('The request timed out. Please try again.');
    }

      // catch(e)
      // {
      //   throw Exception('unexpedted error $e');
      // }


  }
}