import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/farm_model.dart';
import 'package:smartfarm/profile.dart';
import '../style/Mystyle.dart';
import '../style/dialog.dart';

class edit_farm extends StatefulWidget {
  const edit_farm({Key? key}) : super(key: key);

  @override
  State<edit_farm> createState() => _edit_farmState();
}

class _edit_farmState extends State<edit_farm> {
  TextEditingController edit2 = TextEditingController();
  TextEditingController edit3 = TextEditingController();
  TextEditingController edit4 = TextEditingController();
  TextEditingController edit5 = TextEditingController();
  TextEditingController edit6 = TextEditingController();
  TextEditingController edit7 = TextEditingController();
  TextEditingController edit8 = TextEditingController();
  TextEditingController edit9 = TextEditingController();
  TextEditingController edit10 = TextEditingController();
  TextEditingController edit11 = TextEditingController();
  TextEditingController edit12 = TextEditingController();
  TextEditingController edit13 = TextEditingController();
  List<FarmModel> farmModel = [];
  Map arguments = Map();
  String data_ID = "";
  @override
  void initState() {
    getdata_by_id();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['farm_id']);
    data_ID = arguments['farm_id'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 74, 216, 8),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: const Text(" "),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'แก้ไขข้อมูลรอบปลูก',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: const Text(
              "แก้ไขข้อมูลรอบปลูก",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_farm_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_farm_name(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_address(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_tumbon(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_amphur(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_province(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_email(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_email(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_password(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_typeuser(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_lat(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_Lng(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputCusbut(),
        ],
      ),
    );
  }

  Widget inputCusbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                editdata();
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => Profile());
                Navigator.push(context, route);
              },
              style: ElevatedButton.styleFrom(
                primary: MyStyle().textColor,
                onPrimary: Colors.blueAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'แก้ไข',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );

  String? data_IDa = '';
  gettextdata(String? ID,
      {String? farm_id , farm_name, address, tumbon, amphur,province, email, password, typeuser, lat,Lng}) async {
    setState(() {
      data_IDa = ID ?? '';
      edit2.text = farm_id ?? '';
      edit3.text = farm_name ?? '';
      edit4.text = address ?? '';
      edit5.text = tumbon ?? '';
      edit6.text = amphur ?? '';
      edit7.text = province ?? '';
      edit8.text = email ?? '';
      edit9.text = password ?? '';
      edit10.text = typeuser ?? '';
      edit11.text = lat ?? '';
      edit12.text = Lng ?? '';
    });
  }
// String? farm_id, farm_name, email;

//   getName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       farm_id = preferences.getString('farm_id');
//       farm_name = preferences.getString('farm_name');
//       email = preferences.getString('email');
//     });
//   }

  Future<Null> getdata_by_id() async {
    farmModel.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/GetEditFarm.php?farm_id=${data_ID}&isAdd=item';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      data_IDa = data_ID;
      edit2.text = result['farm_id'];
      edit3.text = result['farm_name'];
      edit4.text = result['address'];
      edit5.text = result['tumbon'];
      edit6.text = result['amphur'];
      edit7.text = result['province'];
      edit8.text = result['email'];
      edit9.text = result['password'];
      edit10.text = result['typeuser'];
      edit11.text = result['lat'];
      edit12.text = result['Lng'];
    });
  }

  Future<Null> editdata() async {
    final farm_id = edit2.text,
        farm_name = edit3.text,
        address = edit4.text,
        tumbon = edit5.text,
        amphur = edit6.text,
        province = edit7.text,
        email = edit8.text,
        password = edit9.text,
        typeuser = edit10.text,
        lat = edit11.text,
        Lng = edit12.text;
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/edit_farm.php?isAdd=true&farm_id=$data_ID&farm_name=$farm_name&address=$address&tumbon=$tumbon&amphur=$amphur&province=$province&email=$email&password=$password&typeuser=$typeuser&lat=$lat&Lng=$Lng';
    await Dio().get(url).then((value) {
      print(url);
      print(value);
      if (value.toString() == 'true') {
        getdata_by_id();
        setState(() {
          edit2.text = '';
          edit3.text = '';
          edit4.text = '';
          edit5.text = '';
          edit6.text = '';
          edit7.text = '';
          edit8.text = '';
          edit9.text = '';
          edit10.text = '';
          edit11.text = '';
          data_IDa = '';
        });
      } else if (value.toString() == 'havedata') {
        normalDialog(context, 'มีไอดีนี้อยู่แล้วกรุณาลองใหม่');
      } else {
        // normalDialog(context, 'กรุณาลองใหม่ มีอะไร? ผิดพลาด');
      }
    });
  }

  Widget input_farm_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller: edit2,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสฟร์าม :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_farm_name() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit3,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อฟร์าม :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

//================= เริ่มสร้าง Field =============
  Widget input_address() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit4 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ที่อยู่ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_tumbon() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit5 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ตำบล :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_amphur() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit6 ,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อำเภอ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_province() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit7 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'จังหวัด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_email() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:  edit8,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อีเมล์ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_password() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:  edit9 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสผ่าน :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_typeuser() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller: edit10 ,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ประเภท :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_lat() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller:edit11 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ละติจูด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_Lng() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller: edit12 ,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ลองติจูด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
}
