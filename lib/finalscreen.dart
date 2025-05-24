import 'package:flutter/material.dart';
import 'package:weather/weatherclass.dart';
import 'package:intl/intl.dart';
class FinalScreen extends StatelessWidget {
  final WeatherModel datas;
  const FinalScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    String url;
     DateTime loc=datas.location.local;
     String loctime=DateFormat('HH:mm a').format(loc);
     String locdate = DateFormat('d MMMM, yyyy').format(loc); 
     final width=MediaQuery.of(context).size.width;
     final height=MediaQuery.of(context).size.height;
     final temperature=datas.current.tempc;
     
    
     if(temperature>=10&&temperature<20)
     {
      url='assets/images/windy.png';
     }
       else if(temperature>=20&&temperature<30)
     {
      url='assets/images/sun.png';
     }
      else if(temperature>=30&& temperature<40)
     {url='assets/images/clouds.png';

     }
     else
     {
      url=datas.current.condition.icon;
     }
        var conditiontext = TextStyle(
    
    fontSize: width*0.05,
    fontWeight: FontWeight.bold,
    
  );
    return 
       Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2016/03/28/20/39/sky-1286888_1280.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 20, 0),
            child: ScrollConfiguration(
               behavior: ScrollConfiguration.of(context).copyWith(
    scrollbars: false,
    overscroll: false, 
  ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: width*0.1,
                          height: height*0.1,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: width*0.05,
                                color: Colors.green,
                              )),
                        ),
                        SizedBox(
                          width: width*0.05,
                        ),
                        Icon(
                          Icons.place,
                          size: width*0.1,
                          color: Colors.pink,
                        ),
                        Text(
                          ' ${datas.location.name}',
                          style: TextStyle(
                            fontSize: width*0.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.05,),
                    Center(
                      child: Container(
                        width: width*0.5,
                        height: height*0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                             url,
                              
                            ),
                            fit: BoxFit.cover,
                            ),
                        ),
                       
                      ),
                    ),
                    Text(locdate,style: conditiontext,),
                    Text(loctime,style: conditiontext,),
                    Text('${datas.current.condition.text} with Temperature at ${datas.current.tempc}° cel  ',
                    style: conditiontext,),
                    SizedBox(
                      height: height*0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       msc('LATITUDE',datas.location.latitude.toStringAsFixed(2),' °',Icons.map, context),
                                       SizedBox(width: 20),
                      msc('LONGITUDE',datas.location.longitude.toStringAsFixed(2),' °',Icons.explore,context),
                                     ],
                    ),
                    SizedBox(height: 40),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   msc('WIND',datas.current.wind.toStringAsFixed(2),'mp/h',Icons.air,context),
                   SizedBox(width: 20),
                      msc('TEMPERATURE',datas.current.tempc.toStringAsFixed(2),' °C',Icons.thermostat,context),
                 ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
             );
    
  }

  Container msc(String type,String dt,String msg ,IconData myicon,BuildContext context)
  { 
     final width=MediaQuery.of(context).size.width;
     final height=MediaQuery.of(context).size.height;
     final containerwidth=width*0.4;
       var word = TextStyle(
   color: Colors.white,
    fontSize: containerwidth*0.12,
    fontWeight: FontWeight.w100,
    
  );
   var val = TextStyle(
    
    fontSize: containerwidth*0.15,
    fontWeight: FontWeight.bold,
  );

   return Container(
                  width: containerwidth,
                  height: height*0.25,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(type,style: word,maxLines: 1,),
                     Padding(
                       padding: const EdgeInsets.only(left: 20),
                       child: Icon(myicon,size: width*0.1,color: Colors.pink,),
                     ),
                      Text('$dt$msg',style: val,),
                    ],
                   ),
                 ),
                );
  }
}
