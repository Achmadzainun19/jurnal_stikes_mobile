import 'package:flutter/material.dart';
import 'package:new_absensi/detail_log_book.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Kalender extends StatefulWidget {
  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {

  var tanggal; 

  CalendarController _controller;
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller= CalendarController();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation:0.0,
        title:Text('Kalender',style: TextStyle(color:Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none,color: Colors.white,),
            onPressed: (){

            },
          ),
        ],
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            TableCalendar(
              // initialCalendarFormat: CalendarFormat.twoWeeks,
              calendarStyle: CalendarStyle(
                todayColor:Colors.pink,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color:Colors.white,
                )
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color:Colors.white,
                )
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDayLongPressed: (date,event){
                  tanggal = DateFormat('yyyy-MM-dd').format(date);
                  print(tanggal);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Detail_log_book(tanggal_sekarang:tanggal)),);
              },
              onDaySelected: (date,events){
                // print(date.toIso8601String());
                // date;
                print(DateFormat('dd MM yyyy').format(date));
              },
              builders: CalendarBuilders(
                selectedDayBuilder:(context,date,event)=>
                  Container(
                    margin: EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration:BoxDecoration(
                      color:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text(date.day.toString(),style: TextStyle(
                      color:Colors.white,
                    ))
                    ),
                todayDayBuilder:(context,date,event)=>
                  Container(
                    margin: EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration:BoxDecoration(
                      color:Colors.orange,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text(date.day.toString(),style: TextStyle(
                      color:Colors.white,
                    ))
                    )
              ),
              calendarController: _controller,)
        ])
      
      ,)
    );
  }
}