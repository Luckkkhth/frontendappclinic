// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/baradmin.dart';
import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:flutter/services.dart';
import 'package:clinicapp/api/apiclinic.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/api/apiclinicwaiting.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/widgets/show_progress.dart';
import 'package:location/location.dart';
import '../../utility/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:image_picker/image_picker.dart';
import '../../api/apiclinicwaiting.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // ignore: unused_field
  // ignore: unused_field
  String _nameClinics = "";
  // ignore: unused_field
  String _addressClinics = "";
  // ignore: unused_field
  String _tellClinics = "";
  // ignore: unused_field
  String _timeClinics = "";
  // ignore: unused_field
  String _imgClinics = "";
  // ignore: unused_field
  String _detailClinics = "";
  // ignore: unused_field
  // ignore: unused_field
  String _latitudeClinics = "";
  // ignore: unused_field
  String _longitudeClinics = "";
  // ignore: unused_field
  String _searchClinics = "";

  // ignore: unused_field

  ApiProvidersadmin api2 = ApiProvidersadmin();
  //Register api = Register();

  // ignore: unused_field
  TextEditingController _ctrlNameClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlAddressClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTellClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTimeClinics = TextEditingController();

  // ignore: unused_field

// ignore: unused_field
  TextEditingController _ctrlVehicleClinics = TextEditingController();
  // ignore: unused_field
  TextEditingController _ctrlImgClinics = TextEditingController();
  // ignore: unused_field
  TextEditingController _ctrlSearchClinics = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  String aa = '11';
  String _typeClinics = '-----';
  String _vehicleClinics = '-----';
  static const menuItems = <String>[
    '-----',
    'สหคลินิก',
    'คลินิกสัตว์',
    'กุมารเวชกรรม',
    'ทันตกรรม',
    'พยาบาลและการผดุงครรค์',
    'ศัลยกรรมกระดูกและข้อ',
    'กายยภาพบำบัด',
    'เทคนิคการแพทย์',
    'การแพทย์แผนไทย',
    'หัวใจและทรวงอก',
    'การแพทย์แผนจีน',
    'รังสีเทคนิก',
    'จิตวิทยาคลินิก',
    'กายอุปกรณ์',
    'กิจกรรมบำบัด',
    'ผิวหนัง',
    'สูตินรีเวช',
    'ฝังเข็ม',
    'สมองและระบบประสาท',
    'ระบบทางเดินอาหารและตับ'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  static const menuItems2 = <String>[
    '-----',
    'รถทุกชนิด',
    'รถจักรยานยนต์',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems2 = menuItems2
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            textAlign: TextAlign.left,
          ),
        ),
      )
      .toList();
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  void initState() {
    super.initState();
  }

  String? numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  Row buildName(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ชื่อคลินิก : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _nameClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกชื่อคลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildAddresse(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ที่อยู่ : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _addressClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกชื่อคลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildTime(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('เวลาทำการ : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _timeClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกเวลาทำการ !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row builddetail(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('รายละเอียด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _detailClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกรายละเอียดของคลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildTell(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('เบอร์โทร : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _tellClinics = value,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกเบอร์โทร !';
                  } else if (value[0] != "0") {
                    return 'รูปแบบเบอร์โทรไม่ถูกต้อง !';
                  } else if (value.length != 10) {
                    return 'จำนวนเบอร์โทรไม่ถูกต้อง !';
                  }
                  return null;
                }),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildlatitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ค่าละติจูด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _latitudeClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกค่าละติจูด !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildlongitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ค่าลองจิจูด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _longitudeClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกค่าละติจูด !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildsearch(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('อาการป่วย : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) => _searchClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกอาการป่วย !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildtype(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ประเภท : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: ListTile(
                //title: const Text('ประเภทคลินิก  :'),
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Must be one of items.value.
                    value: _typeClinics,
                    hint: const Text('-----',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _typeClinics = newValue);
                      }
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildcar(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('รถที่สะดวก : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _vehicleClinics,
                    hint: const Text('-----',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _vehicleClinics = newValue);
                      }
                    },
                    items: _dropDownMenuItems2,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 81, 3),
        centerTitle: true,
        title: Text(
          'แอปพลิเคชั่นค้นหาคลินิก',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansThai'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BarAdminScreen(
                index: 0,
              );
            }));
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 26.0,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WellcomeScreen();
                  }));
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text('เพิ่มข้อมูลคลินิกสำหรับแอดมิน',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), //ซ้าย,บน,ขวา,ล่าง
              child: GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imagePath = image!;
                  });
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      imagePath != null
                          ? Container(
                              height: 160,
                              width: 160,
                              child: Image.file(File(imagePath!.path)))
                          : Container(
                              height: 160,
                              width: 160,
                              child: Image.asset("images/img.png"),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            buildName(size),
            SizedBox(
              height: 10,
            ),
            buildtype(size),
            SizedBox(
              height: 10,
            ),

            buildAddresse(size),
            SizedBox(
              height: 10,
            ),

            buildTell(size),
            SizedBox(
              height: 10,
            ),
            buildTime(size),
            SizedBox(
              height: 10,
            ),

            builddetail(size),
            SizedBox(
              height: 10,
            ),
            buildcar(size),
            SizedBox(
              height: 10,
            ),
            buildsearch(size),
            //buildvehicle(size),
            SizedBox(
              height: 10,
            ),

            buildlatitude(size),
            SizedBox(
              height: 10,
            ),
            buildlongitude(size),
            SizedBox(
              height: 10,
            ),

            // buildImg(size),

            buildCreatClinic(context),
          ])),
        ),
      ),
    );
  }

  AnimatedButton buildCreatClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(251, 182, 6, 1),
      width: 200,
      height: 60,
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final dataClinicadmin = await api2.doClinicadmin(
              "",
              _nameClinics,
              _addressClinics,
              _tellClinics,
              _imgClinics,
              _timeClinics,
              _typeClinics,
              _detailClinics,
              _vehicleClinics,
              _latitudeClinics,
              _longitudeClinics,
              imagePath,
              "",
              _searchClinics);
          print(dataClinicadmin);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BarAdminScreen(
              index: 0,
            );
          }));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("บันทึกข้อมูลเรียบร้อย")));
          if (dataClinicadmin == "ชื่อซ้ำ") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("vbv")));
          }
        }
      },
      child: Row(
        children: [
          SizedBox(
              height: 30, width: 60, child: Image.asset("images/save.png")),
          Text(
            'บันทึกข้อมูล',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'NotoSansThai'),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 48, 48),
          width: 3,
        ));
  }
}
