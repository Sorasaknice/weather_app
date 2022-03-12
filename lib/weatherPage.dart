import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projecttermapp/Drawer.dart';
import 'package:projecttermapp/apiKhonkane.dart';
import 'package:projecttermapp/apiMahasarakham.dart';
import 'apiBangkok.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:intl/intl.dart';

class weatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _weatherPage();
  }
}

class _weatherPage extends State<weatherPage> {
  final String titleString = "Weather";

  apiBangkok? DataBangkok;
  apiKhonkane? DataKhonkane;
  apiMahasarakham? DataMahasarakham;
  List allData = [];

  //เรียก api_Bangkok
  Future<List> getData() async {
    final queryBangkok = {
      'lat': '13.75',
      'lon': '100.52',
      'appid': '2f3dab2b938dd706e211838e6dcdb2a6',
    };

    final queryKhonKane = {
      'lat': '16.43889',
      'lon': '102.82861',
      'appid': '2f3dab2b938dd706e211838e6dcdb2a6',
    };

    final queryMahasarakham = {
      'lat': '16.17722',
      'lon': '103.30083',
      'appid': '2f3dab2b938dd706e211838e6dcdb2a6',
    };

    var urlBangkok =
        Uri.http('api.openweathermap.org', '/data/2.5/weather', queryBangkok);
    var urlKhonKane =
        Uri.http('api.openweathermap.org', '/data/2.5/weather', queryKhonKane);
    var urlMahasarakham = Uri.http(
        'api.openweathermap.org', '/data/2.5/weather', queryMahasarakham);

    //var IconKKU = Uri.http('http://openweathermap.org/img/wn/03n@2x.png);

    final responeBangkok = await http.get(urlBangkok);
    final responeKhonKane = await http.get(urlKhonKane);
    final responeMahasarakham = await http.get(urlMahasarakham);

    // Try to convert json to dart object
    // ignore: non_constant_identifier_names
    final jsonBangkok = jsonDecode(responeBangkok.body);
    final jsonKhonkane = jsonDecode(responeKhonKane.body);
    final jsonMahasarakham = jsonDecode(responeMahasarakham.body);
    //print(jsonBangkok.);

    DataBangkok = apiBangkok.fromJson(jsonBangkok);
    DataKhonkane = apiKhonkane.fromJson(jsonKhonkane);
    DataMahasarakham = apiMahasarakham.fromJson(jsonMahasarakham);

    //DataKhonkane = apiBangkok.fromJson(jsonBangkok);
    print(DataMahasarakham!.IconURL);

    allData.add(DataBangkok);
    allData.add(DataKhonkane);
    allData.add(DataMahasarakham);

    return allData;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: widgetDrawer(),
      appBar: new AppBar(
        title: new Text(titleString),
      ),
      body: Center(
          child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            //อุณหภูมิ Kavin

            double kavinBKK =
                double.parse(DataBangkok!.main!.temp.toString()) - 273.15;
            double kavinKKU =
                double.parse(DataKhonkane!.main!.temp.toString()) - 273.15;
            double kavinMSU =
                double.parse(DataMahasarakham!.main!.temp.toString()) - 273.15;

            double kavinBKKmin =
                double.parse(DataBangkok!.main!.tempMin.toString()) - 273.15;
            double kavinKKUmin =
                double.parse(DataKhonkane!.main!.tempMin.toString()) - 273.15;
            double kavinMSUmin =
                double.parse(DataMahasarakham!.main!.tempMin.toString()) - 273.15;
            
            double kavinBKKmax =
                double.parse(DataBangkok!.main!.tempMax.toString()) - 273.15;
            double kavinKKUmax =
                double.parse(DataKhonkane!.main!.tempMax.toString()) - 273.15;
            double kavinMSUmax =
                double.parse(DataMahasarakham!.main!.tempMax.toString()) - 273.15;

            int tempBKK = kavinBKK.round();
            int tempKKU = kavinKKU.round();
            int tempMSU = kavinMSU.round();

            int tempBKKmin = kavinBKKmin.round();
            int tempKKUmin = kavinKKUmin.round();
            int tempMSUmin = kavinMSUmin.round();

            int tempBKKmax = kavinBKKmax.round();
            int tempKKUmax = kavinKKUmax.round();
            int tempMSUmax = kavinMSUmax.round();

            int srB = int.parse(DataBangkok!.sys!.sunrise.toString());
            int srK = int.parse(DataKhonkane!.sys!.sunrise.toString());
            int srM = int.parse(DataMahasarakham!.sys!.sunrise.toString());
            var sunriseBKK = new DateTime.fromMillisecondsSinceEpoch(srB * 1000)
                .formatDateTime().substring(11);
            var sunriseKKU = new DateTime.fromMillisecondsSinceEpoch(srK * 1000)
                .formatDateTime().substring(11);
            var sunriseMSU = new DateTime.fromMillisecondsSinceEpoch(srM * 1000)
                .formatDateTime().substring(11);

            int ssB = int.parse(DataBangkok!.sys!.sunset.toString());
            int ssK = int.parse(DataKhonkane!.sys!.sunset.toString());
            int ssM = int.parse(DataMahasarakham!.sys!.sunset.toString());
            var sunsetBKK = DateTime.fromMillisecondsSinceEpoch(ssB * 1000)
                .formatDateTime().substring(11);
            var sunsetKKU = DateTime.fromMillisecondsSinceEpoch(ssK * 1000)
                .formatDateTime().substring(11);
            var sunsetMSU = DateTime.fromMillisecondsSinceEpoch(ssM * 1000)
                .formatDateTime().substring(11);

            //var formatter = new DateFormat.jm();
            //sunriseBKK = DateFormat;
            var now = DateTime.now();
            //print(now);
            //print(sunsetKKU);
            //sunsetBKK = sunsetBKK.jm();
            //DateTime s =

            String timestamp = DateFormat.MMMMEEEEd().format(now);

            //var string = ' ${sunsetKKU}' ;
            print(sunsetMSU);


            // String engDescBangkok = (DataBangkok!.desc.toString());
            // String engDescKhonkane = (DataKhonkane!.desc.toString());
            // String engDescMaha = (DataMahasarakham!.desc.toString());

            //List weatherTH =
            //['ปลอดโปร่ง','มีเมฆเล็กน้อย','เมฆกระจัดกระจาย','เมฆเกาะกลุ่ม','ฝนโปรยปราย','ฝนตก','ฝนตกหนัก','มีหิมะ','หมอก'];

            return SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 320,
                        width: 400,
                        child: Card(
                          child: Column (
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text( '${DataBangkok!.name}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 24 , ),),
                              ),
                              Center(
                                child: Text('$timestamp'),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( '${DataBangkok!.desc}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 15 , ),),
                                        Text( 'wind : ' '' '${DataBangkok!.wind!.speed}' ' ' 'Km/hr', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'humidity : ' '' '${DataBangkok!.main!.humidity}' ' ' '%', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunrise : ' '' '${sunriseBKK}' ' ' 'AM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunset : ' '' '${sunsetBKK}' ' ' 'PM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),)
                                      ],
                                    )
                                  ),
                                  SizedBox(width: 80,),
                                  Column(
                                    children: [
                                      Image.network(DataBangkok!.IconURL)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text( '$tempBKK' ' ' '°C'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 50 , ),),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text('min ' '$tempBKKmin' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text('max ' '$tempBKKmax' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),
                          elevation: 8,
                          shadowColor: Colors.blue.shade400,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blueGrey)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 320,
                        width: 400,
                        child: Card(
                          child: Column (
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text( '${DataKhonkane!.name}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 24 , ),),
                              ),
                              Center(
                                child: Text('$timestamp'),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( '${DataKhonkane!.desc}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 15 , ),),
                                        Text( 'wind : ' '' '${DataKhonkane!.wind!.speed}' ' ' 'Km/hr', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'humidity : ' '' '${DataKhonkane!.main!.humidity}' ' ' '%', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunrise : ' '' '${sunriseKKU}' ' ' 'AM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunset : ' '' '${sunsetKKU}' ' ' 'PM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),)
                                      ],
                                    )
                                  ),
                                  SizedBox(width: 80,),
                                  Column(
                                    children: [
                                      Image.network(DataKhonkane!.IconURL)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text( '$tempKKU' ' ' '°C'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 50 , ),),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text('min ' '$tempKKUmin' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text('max ' '$tempKKUmax' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                      ],
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
                          elevation: 8,
                          shadowColor: Colors.blue.shade400,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blueGrey)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 320,
                        width: 400,
                        child: Card(
                          child: Column (
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text( '${DataMahasarakham!.name}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 24 , ),),
                              ),
                              Center(
                                child: Text('$timestamp'),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( '${DataMahasarakham!.desc}'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 15 , ),),
                                        Text( 'wind : ' '' '${DataMahasarakham!.wind!.speed}' ' ' 'Km/hr', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'humidity : ' '' '${DataMahasarakham!.main!.humidity}' ' ' '%', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunrise : ' '' '${sunriseMSU}' ' ' 'AM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text( 'sunset : ' '' '${sunsetMSU}' ' ' 'PM', style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),)
                                      ]
                                      ,
                                    )
                                  ),
                                  SizedBox(width: 80,),
                                  Column(
                                    children: [
                                      Image.network(DataMahasarakham!.IconURL)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text( '$tempMSU' ' ' '°C'.toUpperCase() , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 50 , ),),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text('min ' '$tempMSUmin' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                        Text('max ' '$tempMSUmax' ' ' '°C' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 10 , ),),
                                      ],
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
                          elevation: 8,
                          shadowColor: Colors.blue.shade400,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blueGrey)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
