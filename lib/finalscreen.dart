import 'package:flutter/material.dart';
import 'package:weather/weatherclass.dart';
import 'package:intl/intl.dart';
class FinalScreen extends StatelessWidget {
  final WeatherModel datas;
  const FinalScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
     DateTime loc=datas.location.local;
     String loctime=DateFormat('HH:mm a').format(loc);
     String locdate = DateFormat('d MMMM, yyyy').format(loc); 
     final width=MediaQuery.of(context).size.width;
     final height=MediaQuery.of(context).size.height;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
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
                            size: 30,
                            color: Colors.green,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.place,
                      size: 50,
                      color: Colors.pink,
                    ),
                    Text(
                      ' ${datas.location.name}',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.01,),
                Container(
                  width: double.infinity,
                  height: height*0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        datas.current.condition.icon,
                        
                      ),
                      fit: BoxFit.cover,
                      ),
                  ),
                 
                ),
                Text(locdate,style: conditiontext,),
                Text(loctime,style: conditiontext,),
                Text('${datas.current.condition.text} with Temperature at ${datas.current.tempc}° cel  ',
                style: conditiontext,),
                SizedBox(
                  height: height*0.02,
                ),
                Row(
             children: [
               msc('LATITUDE',datas.location.latitude.toStringAsFixed(2),' °',Icons.map, context),
               SizedBox(width: 10),
                  msc('LONGITUDE',datas.location.longitude.toStringAsFixed(2),' °',Icons.explore,context),
             ],
                ),
                SizedBox(height: 20),
                   Row(
             children: [
               msc('WIND',datas.current.wind.toStringAsFixed(2),'mp/h',Icons.air,context),
               SizedBox(width: 10),
                  msc('TEMPERATURE',datas.current.tempc.toStringAsFixed(2),' °CEL',Icons.thermostat,context),
             ],
                ),
                
              ],
            ),
          ),
        ),
             );
    
  }

  Container msc(String type,String dt,String msg ,IconData myicon,BuildContext context)
  { 
     final width=MediaQuery.of(context).size.width;
     final height=MediaQuery.of(context).size.height;
       var word = TextStyle(
   color: Colors.white,
    fontSize: width*0.05,
    fontWeight: FontWeight.w100,
  );
   var val = TextStyle(
    
    fontSize: width*0.05,
    fontWeight: FontWeight.bold,
  );

   return Container(
                  width: width*0.4,
                  height: height*0.17,
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
                      Text(type,style: word,),
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
