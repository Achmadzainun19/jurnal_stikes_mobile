import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:new_absensi/edit_log.dart';
import 'package:new_absensi/tambah_log.dart';

import 'dart:async';
import 'dart:convert';

class Detail_log_book extends StatefulWidget {

 final tanggal_sekarang; 

  Detail_log_book({this.tanggal_sekarang});

  @override
  _Detail_log_bookState createState() => _Detail_log_bookState();
}

class _Detail_log_bookState extends State<Detail_log_book> {

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Future<List> kegiatan;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Future<List> getData() async{
    // final response=await http.get(
    //   Uri.encodeFull("http://192.168.42.231/rest_ci/index.php/mahasiswa"),
    //   headers: {
    //     "Accept":"aplication/json"
    //   }
    // );
    final response =await http.get("http://192.168.4.32/rest_ci/index.php/log_book/cari_tanggal?tanggal="+widget.tanggal_sekarang);
    return json.decode(response.body);
  }

  void deleteData(id){
    setState(() {
      http.delete("http://192.168.4.32/rest_ci/index.php/log_book/hapus?id="+id).then((_){
        getData();
        initState();
      });
    });
  }

  Future<List> _refresh() async{
    setState(() {
      return http.get("http://192.168.4.32/rest_ci/index.php/log_book").then((_) {
        getData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation:0.0,
        title:Text('Detail Log Book',style: TextStyle(color:Colors.white),),
      ),
      body:Center(
          child:SingleChildScrollView(
          child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                  child:Container(
                    height: 300,
                    child:new FutureBuilder<List>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                            ? 
                            // new ItemList(
                            //     list: snapshot.data,
                            //   )
                            ListView.builder(
                              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                              itemBuilder: (context, i) {
                                var angka=i+1;
                                return InkWell(
                                        onTap: () {},
                                        child:Container(
                                        padding:EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                            child:
                                            SizedBox(
                                                  height:35.0,
                                                  width:35.0,
                                                  child:Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "$angka",
                                                      style:TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w700
                                                      ),
                                                      
                                                    ),decoration: BoxDecoration(
                                                      shape:BoxShape.circle,
                                                      color:Colors.blue,
                                                    ),
                                                    padding: EdgeInsets.all(10.0),
                                                  )
                                                ),
                                            ),
                                            Container(
                                              width:MediaQuery.of(context).size.width*0.65,
                                              padding:EdgeInsets.only(left:10),
                                              alignment: Alignment.topLeft,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[ 
                                                  Text("Pukul : ${snapshot.data[i]['waktu_log']}",style:TextStyle(color:Colors.black, fontWeight: FontWeight.w700, fontSize:16.0),textAlign: TextAlign.left),
                                                  SizedBox(height:2.0, width:100.0, child:Container(color:Colors.orange)),
                                                  SizedBox(height:4.0),
                                                  Text("${snapshot.data[i]['nama_log']}",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.left,),
                                                  Text("${snapshot.data[i]['deskripsi_log']}",textAlign: TextAlign.left),
                                                ]
                                              )
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              color: Colors.black,
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context, 
                                                  builder: (context){
                                                    return Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        ListTile(
                                                        leading: Icon(Icons.edit),
                                                        title:Text("edit"),
                                                        onTap:()=>{ 
                                                          Navigator.of(context).push(
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext context)=> Edit_log(reloadData:getData,list:snapshot.data , index: i,)
                                                          ))
                                                        }
                                                        ),
                                                        ListTile(
                                                        leading: Icon(Icons.delete),
                                                        title:Text("delete"),
                                                        onTap:()=>{
                                                          deleteData(snapshot.data[i]['id_log_book']),
                                                          Navigator.pop(context),

                                                          // _confirm(snapshot.data[i]['id_log_book'],context),
                                                        }
                                                        ),
                                                      ]
                                                      
                                                    );
                                                  }
                                                  );
                                              }
                                            ),
                                        ]),
                                      ),);
                              },
                            )
                            : new Center(
                                child: new CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                  )
                ],
          )
        )
      )
    );
  }
}