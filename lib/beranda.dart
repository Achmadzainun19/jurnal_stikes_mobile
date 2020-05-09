import 'package:flutter/material.dart';
import 'dart:async';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

  Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
       counter++; 
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation:0.0,
        title:Text('Beranda',style: TextStyle(color:Colors.white),),
        actions: <Widget>[
          Text(counter.toString()),
          IconButton(
            icon: Icon(Icons.notifications_none,color: Colors.white,),
            onPressed: (){

            },
          ),
        ],
      ),
      body:Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child:Column(
            children: <Widget>[
              SizedBox(height:40.0),
              Container(
                child: Image.asset("assets/log.png",height: 150,),
              ),
              Text(
                "Stikom PGRI Banyuwangi ",
                style: TextStyle(
                  fontSize:16.0,
                  color:Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height:8.0),
              Text(
                "E Log BOOK ",
                style: TextStyle(
                  fontSize:30.0,
                  color:Colors.cyan[700],
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height:10.0),
              Text(
                "Aplikasi E log Book ini adalah aplikasi yang di khususkan untuk para management dan juga dosen sebagai media pencatatan kegiatan mengajar , pengelolaan management dan lain lain yang berhubungan dengan kampus",
                style: TextStyle(
                  fontSize:14.0,
                  color:Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
                textAlign:TextAlign.center,
              ),
              
            ],)
        ),
      )
    );
  }
}