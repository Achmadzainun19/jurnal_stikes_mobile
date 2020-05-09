import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_absensi/edit_log.dart';
import 'package:new_absensi/tambah_log.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Log_book extends StatefulWidget {
  Log_book(); 

  @override
  _Log_bookState createState() => _Log_bookState();
}

class _Log_bookState extends State<Log_book> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  
  int jum_kegiatan;

  @override
  void initState() {
    super.initState();
    getData();
    jum_kegiatan=3;
    jumData();
  }

  @override
  Future<List> getData() async{
     var tanggal= DateTime.now();
     var tanggal_sekarang= DateFormat('yyyy-MM-dd').format(tanggal);
    // final response=await http.get(
    //   Uri.encodeFull("http://192.168.42.231/rest_ci/index.php/mahasiswa"),
    //   headers: {
    //     "Accept":"aplication/json"
    //   }
    // );
    final response =await http.get("http://192.168.1.10/rest_ci/index.php/log_book/cari_tanggal?tanggal="+tanggal_sekarang);
    return json.decode(response.body);
  }

  void jumData() async{
    var tanggal= DateTime.now();
    var tanggal_sekarang= DateFormat('yyyy-MM-dd').format(tanggal);
    final response =await http.get("http://192.168.1.10/rest_ci/index.php/log_book/jum_data_cari_tanggal?tanggal="+tanggal_sekarang);
    return json.decode(response.body);
  }

  void deleteData(id){
    setState(() {
      http.delete("http://192.168.1.10/rest_ci/index.php/log_book/hapus?id="+id).then((_){
        getData();
        jumData();
        initState();
      });
    });
  }

  Future<List> _refresh() async{
    setState(() {
      return http.get("http://192.168.1.10/rest_ci/index.php/log_book").then((_) {
        getData();
        jumData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var tanggal= DateTime.now();
    var tanggal_sekarang= DateFormat('dd MMMM  yyyy').format(tanggal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation:0.0,
        title:Text('Log Book',style: TextStyle(color:Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => Tambahlog()),);
            },
          ),
        ],
      ),
      body:
      RefreshIndicator(
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child:Scrollbar(
          child:Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(left:10,right:10,top:10,),
                    child:Container(
                      height:90.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(4.0), color: Colors.grey[200]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            SizedBox(height:15.0),
                            Text(
                              "Jumlah Log Book Hari Ini",
                              style: TextStyle(
                                fontSize:20.0,
                                color:Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tanggal : $tanggal_sekarang",
                              style: TextStyle(
                                fontSize:14.0,
                                color:Colors.black,
                                fontWeight: FontWeight.w100,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                          ),
                          Column(
                            children:<Widget>[
                            Text(
                              "$jum_kegiatan",
                              style: TextStyle(
                                fontSize:60.0,
                                color:Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.only(top:10, bottom:10, left:10, right:10 ),
                    child: Text("List Kegiatan",style: TextStyle( color: Colors.black, fontSize: 16.0,fontWeight: FontWeight.w700),),alignment: Alignment.topLeft 
                  ),
                  Expanded(
                  child:Container(
                    padding: EdgeInsets.only(left:10, right:10,),
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
      ),
      
    );
  
  }
}

// class ItemList extends StatelessWidget {
//   final List list;
//   ItemList({this.list});

//   Future<List> AmbilData() async{
//     final response =await http.get("http://192.168.1.10/rest_ci/index.php/log_book");
//     return json.decode(response.body);
//   }

//   void deleteData(id){
//   http.delete("http://192.168.1.10/rest_ci/index.php/log_book/hapus?id="+id).then((_){
//       AmbilData();
//     });
  
//   }

//   _confirm (id,BuildContext context){
//   AlertDialog alertDialog = new AlertDialog(
//     content: new Text("apakah anda benar benar ingin menghapus  "+id),
//     actions: <Widget>[
//       new RaisedButton(
//         child: new Text("Ya proses",style: new TextStyle(color: Colors.white),),
//         color: Colors.redAccent,
//         onPressed: (){
//           deleteData(id);
//           // Navigator.pop(context);
//           // Navigator.of(context).push(
//           //   new MaterialPageRoute(
//           //     builder: (BuildContext context)=> new Log_book(),
//           //   )
//           // );
//           Navigator.of(context).pushNamed('/Log_book');
          
//           // Navigator.pop(context);
//         },
//       ),
//       new RaisedButton(
//         child: new Text("Batal",style: new TextStyle(color: Colors.white)),
//         color: Colors.lightGreen,
//         onPressed: (){ Navigator.pop(context); Navigator.pop(context); },
//       ),
//     ],
//   );

//   showDialog(context: context, child: alertDialog);
// }


//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: list == null ? 0 : list.length,
//       itemBuilder: (context, i) {
//         var angka=i+1;
//         return InkWell(
//                 onTap: () {},
//                 child:Container(
//                 padding:EdgeInsets.all(5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                     child:
//                     SizedBox(
//                           height:35.0,
//                           width:35.0,
//                           child:Container(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "$angka",
//                               style:TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700
//                               ),
                              
//                             ),decoration: BoxDecoration(
//                               shape:BoxShape.circle,
//                               color:Colors.blue,
//                             ),
//                             padding: EdgeInsets.all(10.0),
//                           )
//                         ),
//                     ),
//                     Container(
//                       width:MediaQuery.of(context).size.width*0.65,
//                       padding:EdgeInsets.only(left:10),
//                       alignment: Alignment.topLeft,
//                       child:Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[ 
//                           Text("Pukul : ${list[i]['waktu_log']}",style:TextStyle(color:Colors.black, fontWeight: FontWeight.w700, fontSize:16.0),textAlign: TextAlign.left),
//                           SizedBox(height:2.0, width:100.0, child:Container(color:Colors.orange)),
//                           SizedBox(height:4.0),
//                           Text("${list[i]['nama_log']}",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.left,),
//                           Text("${list[i]['deskripsi_log']}",textAlign: TextAlign.left),
//                         ]
//                       )
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       color: Colors.black,
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context, 
//                           builder: (context){
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 ListTile(
//                                 leading: Icon(Icons.edit),
//                                 title:Text("edit"),
//                                 onTap:()=>{ 
//                                   Navigator.of(context).push(
//                                   new MaterialPageRoute(
//                                     builder: (BuildContext context)=> Edit_log(list:list , index: i,)
//                                   ))
//                                 }
//                                 ),
//                                 ListTile(
//                                 leading: Icon(Icons.delete),
//                                 title:Text("delete"),
//                                 onTap:()=>{
//                                   _confirm(list[i]['id_log_book'],context),
//                                 }
//                                 ),
//                               ]
                              
//                             );
//                           }
//                           );
//                       }
//                     ),
//                 ]),
//               ),);
//         // return new Container(
//         //   padding: const EdgeInsets.all(10.0),
//         //   child: new GestureDetector(
//         //     onTap:(){},
//         //     child: new Card(
//         //       child: new ListTile(
//         //         title: new Text(list[i]['nama_kegiatan']),
//         //         leading: new Icon(Icons.widgets),
//         //         subtitle: new Text("Stock : ${list[i]['stock']}"),
//         //       ),
//         //     ),
//         //   ),
//         // );
//       },
//     );
//   }
// }
