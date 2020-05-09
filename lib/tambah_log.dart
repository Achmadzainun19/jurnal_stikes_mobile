import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:new_absensi/edit_log.dart';

class Tambahlog extends StatefulWidget {
  @override
  _TambahlogState createState() => _TambahlogState();
}

class _TambahlogState extends State<Tambahlog> {

  DateTime date3;
  DateTime date2;

  TextEditingController controllerjudul = new TextEditingController();
  TextEditingController controllerdeskripsi = new TextEditingController();
  TextEditingController controllertanggal = new TextEditingController();
  TextEditingController controllerwaktu = new TextEditingController();

  void addData(){
    var url="http://192.168.1.10/rest_ci/index.php/log_book/tambah";

    http.post(url, body: {
    "tanggal": controllertanggal.text,
    "waktu": controllerwaktu.text,
    "judul": controllerjudul.text,
    "deskripsi": controllerdeskripsi.text,
  });
  }

  @override
  void initState(){
    var tanggal= DateTime.now();
    var tanggal_sekarang= DateFormat('yyyy-MM-dd').format(tanggal);
    controllertanggal = new TextEditingController(text: tanggal_sekarang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle:true,
        elevation:0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title:Text('E-Log Book',style: TextStyle(color:Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check,color: Colors.white,),
            onPressed: (){
              addData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: 
      ListView(
        padding: EdgeInsets.only(top:15.0, left:20.0, right:20.0),
          
            
            children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tambah Log Book',
                    style:TextStyle(
                      fontSize:25.0,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ],
              )
            ),
            SizedBox(height:15.0),
            Container(
              child: DateTimePickerFormField(
              controller: controllertanggal,
              inputType: InputType.date,
              format: DateFormat("yyyy-MM-dd"),
              editable: true,
              decoration: InputDecoration(
                  labelText: 'Tanggal Log Book',
                  prefixIcon: Icon(Icons.date_range),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: 'Nama Lengkap',
                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
                  contentPadding:
                      EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.7),
                  ),
              ),
            ),
            ),
            SizedBox(height:10.0),
            Container(
              child: DateTimePickerFormField(
                  controller: controllerwaktu,
                  inputType: InputType.time,
                  format: DateFormat("HH:mm"),
                  decoration: InputDecoration(
                    labelText: 'Waktu Log Book',
                    prefixIcon: Icon(Icons.access_time),
                    filled: true,
                    fillColor: Colors.white,
                    // hintText: 'Nama Lengkap',
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
                    contentPadding:
                        EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.7),
                    ),
                  ),
                ),
            ),
            SizedBox(height:10.0),
            Container(
              child: TextField(
              controller: controllerjudul,
              style: new TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                labelText: 'Judul  log Book',
                prefixIcon: Icon(Icons.sort),
                filled: true,
                fillColor: Colors.white,
                // hintText: 'Nama Lengkap',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.7),
                ),
              ),
              ),
            ),
            SizedBox(height:10.0),
            Container(
              child: TextField(
              controller: controllerdeskripsi,
              style: new TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                labelText: 'Deskripsi log Book',
                prefixIcon: Icon(Icons.format_align_justify),
                filled: true,
                fillColor: Colors.white,
                // hintText: 'Nama Lengkap',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.7),
                ),
              ),
              ),
            ),
            SizedBox(height:10.0),

          ],
            ),
    );
  }
}