import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/finalscreen.dart';
import 'package:weather/weatherclass.dart';

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({super.key});

  @override
  State<DisplayWeather> createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
 
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  late Future<WeatherModel> finalweatheroutput;
  final TextEditingController _locationcontroller=TextEditingController(); 
   String loc="punalur";
  @override
void initState()
{
  super.initState();

  finalweatheroutput=Apiservice().fetchrep(loc);

}

void handle() async
{if(_formkey.currentState!.validate())
{
setState(() {
  loc=_locationcontroller.text;
   
  });
//   WeatherModel data= await Apiservice().fetchrep(loc);
try{
    WeatherModel data=await Apiservice().fetchrep(loc);
       if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalScreen(datas: data),
        ),
      );
}
catch(e)
{   if (!mounted) return;
  final errorMessage = e.toString().replaceFirst('Exception: ', '');
   var w=MediaQuery.of(context).size.width;
ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage.toString(),style: TextStyle(
            fontSize: w*0.05,
          ),),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          
        ),
      );
}



}

}

  @override
  Widget build(BuildContext context) {
  
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
       var ts=TextStyle(
   
    color: Colors.black,
    fontSize: width*0.07,
    fontWeight: FontWeight.w100,
  );
    return SafeArea(
      child:Container(
        width: double.infinity,
        height: double.infinity,
            decoration: BoxDecoration(
               image: DecorationImage(
                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSHS3hxClSFRowj-39UnNcl8V7VPQ_ziD6_Q&s'),
                fit: BoxFit.cover,
                )
            ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WEATHER FINDER',style: TextStyle(
                         color: Colors.pink,
                    fontSize: width*0.08,
                    fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: height*0.1,),
                      Text('REALTIME WEATHER UPDATE',style: TextStyle(
                        color: Colors.white,
                        fontSize: width*0.05,
                        fontWeight:FontWeight.w600,
                      ),),
                      SizedBox(height: 20,),
                      Text('FORECAST FOR 10 DAYS',style: TextStyle(
                        color: Colors.white,
                        fontSize:  width*0.05,
                        fontWeight:FontWeight.w600,
                      ),),
                      SizedBox(height: 20,),
                      Text('COMPLETE DASBOARD MONITOR',style: TextStyle(
                        color: Colors.white,
                        fontSize:  width*0.05,
                        fontWeight:FontWeight.w600,
                      ),),
                     
                      SizedBox(height: height*0.2,),
                    
                      SizedBox(
                        width: width*0.8,
                        height: height*0.1,
                   
                        child: TextFormField(
                       
                                            decoration: InputDecoration(
                                
                             border: OutlineInputBorder(),
                                             helperText: ' ',
                                             errorStyle: TextStyle(
                                              fontSize: width*0.05,
                                             ),
                                              hintText: 'ENTER A LOCATION',
                                              hintStyle: ts,
                                              prefixIcon: Icon(Icons.search),
                                             
                         
                                            ),
                                              style: TextStyle(
                            fontSize: width*0.07, // 👈 Set your desired font size here
                            color: Colors.black, // Optional: text color
                          ),
                                          
                                            controller: _locationcontroller,
                                            keyboardType: TextInputType.name,
                                             
                                            validator: (value)
                                            {
                                              if(value==null||value.isEmpty)
                                              {
                        return 'location cannot be empty';
                                              }
                                              final placeNameRegex = RegExp(r"^[\w,.'-]{2,}$"); 
                                              if(!placeNameRegex.hasMatch(value))
                                              {
                         return 'enter a valid location';
                                              }
                                            return null;
                                            },
                         onFieldSubmitted: (value) {
                           handle();
                         },
                                           
                                          ),  
                      ),
                   
                              
                    ],
                  ),
                
            
                  ),
                  
                SizedBox(height: height*0.05,),
                FutureBuilder(
              future: finalweatheroutput, 
              builder: (context,snapshot)
              {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                     return Center(
            child: Column(
                  children: [
                    Icon(
            Icons.place_outlined,
            size: 80,
            color: Colors.redAccent,
                    ),
                    SizedBox(height: 10),
                    Text(
            'ERROR${snapshot.error}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
                    ),
                  ],
            ),
                    );
                  } else if (!snapshot.hasData ) {
                    return Center(
                      child: Text('failed to load a location'),
                    );
                  }
             
              
                  return Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            handle();
                          
                          },
                           child: Container(
                                                 width: width*0.8,
                                                 height: height*0.07,
                                                 decoration: BoxDecoration(
                            color: Colors.green,
                            
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                                                 ),
                                                 child: Center(
                            child: Text('GET STARTED',style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),),
                                                 ),),
                         ),
                        
                    ],
                  );
              }
              
              
              ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}