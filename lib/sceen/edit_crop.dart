import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/crop_model.dart';
import 'package:smartfarm/model/greenhouse_model.dart';
import 'package:smartfarm/model/plant_model.dart';
import 'package:smartfarm/sceen/Show_crop.dart';

import '../style/Mystyle.dart';
import '../style/dialog.dart';

class edit_crop extends StatefulWidget {
  static const routeName = '/edit_crop';
  const edit_crop({Key? key}) : super(key: key);

  @override
  State<edit_crop> createState() => _edit_cropState();
}

class _edit_cropState extends State<edit_crop> {
  TextEditingController edit2 = TextEditingController();
  TextEditingController edit3 = TextEditingController();
  TextEditingController edit4 = TextEditingController();
  TextEditingController edit5 = TextEditingController();
  TextEditingController edit6 = TextEditingController();
  List<CropModel> cropModel = [];
  List categoryItemlist = [];
  List categoryItemlistgh_id = [];
  List<PlantModel> PlantModels = [];
  List<GreehouseModel> greehouseModel = [];
  Map arguments = Map();
  String data_ID = "";
  @override
  void initState() {
    getdata_by_id();
    getplant();
    getgreenhouse();
    super.initState();
  }

  var dropdownvaluegh_id;
  var dropdownvalue;
  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['crop_id']);
    data_ID = arguments['crop_id'];
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
          input_crop_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_plant_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_crop_date(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_gh_id(),
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
                    MaterialPageRoute(builder: (value) => Show_crop());
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
      {String? farm_id, plant_id, crop_date, crop_id, gh_id}) async {
    setState(() {
      data_IDa = ID ?? '';
      edit2.text = farm_id ?? '';
      edit3.text = plant_id ?? '';
      edit4.text = crop_date ?? '';
      edit5.text = crop_id ?? '';
      edit5.text = gh_id ?? '';
    });
  }

  String? farm_id, farm_name, email;

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

/////////////////////////////getPlant//////////////////////////////////////////////////////
  bool readdata = false;
  Future<Null> getplant() async {
    PlantModels.clear();
    print(PlantModels);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getPlant.php?isAdd=true&farm_id=999';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responseplant_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        PlantModel plantModel = PlantModel.fromJson(map);
        setState(() {
          PlantModels.add(plantModel);
          readdata = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlist = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(PlantModels));
    } else {
      setState(() {
        PlantModels = [];
        readdata = false;
      });
    }
  }

// ////////////////////////////////////////////////////////////////////////////
  bool readdata1 = false;
  Future<Null> getgreenhouse() async {
    greehouseModel.clear();
    print(greehouseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getGreenhouse.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsegh_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        GreehouseModel greehouseModels = GreehouseModel.fromJson(map);
        setState(() {
          greehouseModel.add(greehouseModels);
          readdata1 = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistgh_id = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        greehouseModel = [];
        readdata1 = false;
      });
    }
  }

//////////////////////////////////////////////////////////////////////////
  Future<Null> getdata_by_id() async {
    cropModel.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/GetEditCrop.php?crop_id=${data_ID}&isAdd=item';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      data_IDa = data_ID;
      edit2.text = result['farm_id'];
      edit3.text = result['plant_id'];
      edit4.text = result['crop_date'];
      edit5.text = result['crop_id'];
      edit6.text = result['gh_id'];
    });
  }

  Future<Null> editdata() async {
    final farm_id = edit2.text,
        plant_id = edit3.text,
        crop_date = edit4.text,
        gh_id = edit6.text;
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/edit_crop.php?isAdd=true&crop_id=$data_ID&farm_id=$farm_id&plant_id=$dropdownvalue&crop_date=$crop_date&gh_id=$dropdownvaluegh_id';
    await Dio().get(url).then((value) {
      print(url);
      print(value);
      if (value.toString() == 'true') {
        getdata_by_id();
        setState(() {
          edit2.text = '';
          edit3.text = '';
          edit4.text = '';
          edit6.text = '';
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
        child: TextField(
          controller: edit2,
          decoration: InputDecoration(
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
  Widget input_crop_id() => Container(
        width: 250.0,
        child: TextField(
          controller: edit5,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสรอบการปลูก :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  // Widget input_plant_id() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit3,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'รหัสพืช :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_plant_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสพืช',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlist.map((item) {
              return DropdownMenuItem(
                value: item['plant_id'].toString(),
                child: Text(item['plant_name'].toString()),
              );
            }).toList(),
            value: dropdownvalue,
            // onChanged: (newVal) {
            //   setState(() {
            //     dropdownvalue = newVal as String;
            //   });
            // },
            onChanged: (newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );
  Widget input_crop_date() => Container(
        width: 250.0,
        child: TextField(
          controller: edit4,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'วันที่เริ่มปลูก :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  // Widget input_gh_id() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit6,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'รหัสโรงเรียน :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_gh_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสโรงเรียน',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistgh_id.map((item1) {
              return DropdownMenuItem(
                value: item1['gh_id'].toString(),
                child: Text(item1['gh_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluegh_id,
            onChanged: (newVal) {
              setState(() {
                dropdownvaluegh_id = newVal as String;
              });
              //  print(dropdownvaluegh_id);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );
}
