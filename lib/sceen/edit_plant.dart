import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/plant_model.dart';
import 'package:smartfarm/sceen/Show_plant.dart';
import '../style/Mystyle.dart';
import '../style/dialog.dart';

class edit_plant extends StatefulWidget {
  const edit_plant({Key? key}) : super(key: key);

  @override
  State<edit_plant> createState() => _edit_plantState();
}

class _edit_plantState extends State<edit_plant> {
  // TextEditingController data_IDa = TextEditingController();
  TextEditingController eplant_name = TextEditingController();
  TextEditingController eage_min = TextEditingController();
  TextEditingController eage_max = TextEditingController();
  TextEditingController eph_min = TextEditingController();
  TextEditingController eph_max = TextEditingController();
  TextEditingController ehumid_min = TextEditingController();
  TextEditingController ehumid_max = TextEditingController();
  TextEditingController esoil_min = TextEditingController();
  TextEditingController esoil_max = TextEditingController();
  TextEditingController elight_min = TextEditingController();
  TextEditingController elight_max = TextEditingController();
  TextEditingController etemp_min = TextEditingController();
  TextEditingController etemp_max = TextEditingController();
  TextEditingController efertilizer = TextEditingController();
  TextEditingController eplantID = TextEditingController();
  TextEditingController eremark_crop = TextEditingController();
  List<PlantModel> PlantModels = [];
  Map arguments = Map();
  String data_ID = "";
  @override
  void initState() {
    getdata_by_id();
    // getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['plant_id']);
    data_ID = arguments['plant_id'];
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
                'แก้ไขข้อมูลพืช',
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
              "แก้ไขข้อมูลพืช",
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
          input_plant_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_plant_name(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputAgeRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputTempRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputHumidRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputLightRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
           inputSoilRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
           inputPhRange(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
           inputfertilizer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputremark_crop(),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputCusbut(),
        ],
      ),
    );
  }

  // String? farm_id, farm_name, email;

  // getName() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     farm_id = preferences.getString('farm_id');
  //     farm_name = preferences.getString('farm_name');
  //     email = preferences.getString('email');
  //   });
  // }

  Widget inputCusbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                editdata();
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => Show_plant());
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
      {String? plant_name,
      age_min,
      age_max,
      ph_min,
      ph_max,
      humid_min,
      humid_max,
      temp_max,
      soil_min,
      soil_max,
      light_min,
      light_max,
      fertilizer,
      remark_crop,
      temp_min,
      plant_id}) async {
    setState(() {
      data_IDa = ID ?? '';
      eplant_name.text = plant_name ?? '';
      eage_min = age_min ?? '';
      eage_max = age_max ?? '';
      eph_min.text = ph_min ?? '';
      eph_max.text = ph_max ?? '';
      ehumid_min.text = humid_min ?? '';
      ehumid_max.text = humid_max ?? '';
      esoil_min.text = soil_min ?? '';
      esoil_max.text = soil_max ?? '';
      elight_min.text = light_min ?? '';
      elight_max.text = light_max ?? '';
      etemp_min.text = temp_min ?? '';
      etemp_max.text = temp_max ?? '';
      efertilizer.text = fertilizer ?? '';
      eplantID.text = plant_id ?? '';
      eremark_crop.text = remark_crop ?? '';
    });
  }

  Future<Null> getdata_by_id() async {
    PlantModels.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // farm_id = preferences.getString('farm_id');
    String url =
        'http://chiangraismartfarm.com//APIsmartfarm/GetEditPlant.php?plant_id=${data_ID}&isAdd=item';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      data_IDa = data_ID;
      eplant_name.text = result['plant_name'];
      eage_min.text = result['age_min'];
      eage_max.text = result['age_max'];
       eph_min.text = result['ph_min'];
      eph_max.text = result['ph_max'];
      eph_min.text = result['temp_max'];
      eph_max.text = result['temp_min'];
      ehumid_min.text = result['humid_min'];
      ehumid_max.text = result['humid_max'];
      esoil_min.text = result['soil_min'];
      esoil_max.text = result['soil_max'];
      elight_min.text = result['light_min'];
      elight_max.text = result['light_max'];
      etemp_min.text = result['temp_min'];
      etemp_max.text = result['temp_max'];
      efertilizer.text = result['fertilizer'];
      eplantID.text = result['plant_id'];
      eremark_crop.text = result['remark_crop'];
    });
  }

  Future<Null> editdata() async {
    final plant_name = eplant_name.text,
        age_min = eage_min.text,
        age_max = eage_max.text,
        ph_min = eph_min.text,
        ph_max = eph_max.text,
        humid_min = ehumid_min.text,
        humid_max = ehumid_max.text,
        soil_min = esoil_min.text,
        soil_max = esoil_max.text,
        light_min = elight_min.text,
        light_max = elight_max.text,
        temp_min = etemp_min.text,
        temp_max = etemp_max.text,
        fertilizer = efertilizer.text,
        plant_id = eplantID.text,
        remark_crop = eremark_crop.text;
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/edit_plant.php?isAdd=true&plant_id=$plant_id&plant_name=$plant_name&age_min=$age_min&age_max=$age_max&ph_min=$ph_min&ph_max=$ph_max&temp_max=$temp_max&temp_min=$temp_min&soil_max=$soil_max&soil_min=$soil_min&light_max=$light_max&light_min=$light_min&humid_min=$humid_min&humid_max=$humid_max&fertilizer=$fertilizer&eremark_crop=$remark_crop';
    await Dio().get(url).then((value) {
      print(url);
      print(value);
      if (value.toString() == 'true') {
        getdata_by_id();
        setState(() {
          eplant_name.text = '';
          eage_min.text = '';
          eage_max.text = '';
          eph_min.text = '';
          eph_max.text = '';
          ehumid_min.text = '';
          ehumid_max.text = '';
          esoil_min.text = '';
          esoil_max.text = '';
          elight_min.text = '';
          elight_max.text = '';
          etemp_min.text = '';
          etemp_max.text = '';
          efertilizer.text = '';
          eplantID.text = '';
          eremark_crop.text = '';

          data_IDa = '';
        });
      } else if (value.toString() == 'havedata') {
        normalDialog(context, 'มีไอดีนี้อยู่แล้วกรุณาลองใหม่');
      } else {
        // normalDialog(context, 'กรุณาลองใหม่ มีอะไร? ผิดพลาด');
      }
    });
  }

  Widget input_plant_id() => Container(
        width: 250.0,
        child: TextField(
          controller: eplantID,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสพืช :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_plant_name() => Container(
        width: 250.0,
        child: TextField(
          controller: eplant_name,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อพืช :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

 Widget inputfertilizer() => Container(
        width: 250.0,
        child: TextField(
          controller: efertilizer,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'สูตรปุ๋ย :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget inputAgeRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: eage_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อายุพืช (Min):',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: eage_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อายุพืช (Max):',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget inputPhRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: eph_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่า PH (Min):',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: eph_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่า PH (Max):',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget inputTempRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: etemp_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อุหภูมิต่ำสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: etemp_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อุหภูมิสูงสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget inputHumidRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: ehumid_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่าความชื้นสัมพัทธ์ต่ำสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: ehumid_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่าความชื้นสัมพัทธ์สูงสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

       Widget inputSoilRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: esoil_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ความชื้นในดินต่ำสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: esoil_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ความชื้นในดินสูงสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

         Widget inputLightRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: elight_min,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ช่วงแสงต่ำสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: elight_max,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ช่วงแสงสูงสุด :',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyStyle().textColorfocus),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

        Widget inputremark_crop() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller: eremark_crop,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'คำอธิบายเพิ่มเติม :',
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
