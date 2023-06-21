import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/activity_model.dart';
import 'package:smartfarm/model/bug_modeel.dart';
import 'package:smartfarm/model/crop_model.dart';
import 'package:smartfarm/model/diesease_model.dart';
import 'package:smartfarm/sceen/Show_activity.dart';
import '../style/Mystyle.dart';
import '../style/dialog.dart';

class edit_activity extends StatefulWidget {
  static const routeName = '/edit_activity';
  const edit_activity({Key? key}) : super(key: key);

  @override
  State<edit_activity> createState() => _edit_activity();
}

class _edit_activity extends State<edit_activity> {
  TextEditingController edit2 = TextEditingController();
  TextEditingController edit3 = TextEditingController();
  TextEditingController edit4 = TextEditingController();
  TextEditingController edit5 = TextEditingController();
  TextEditingController edit6 = TextEditingController();
  TextEditingController edit7 = TextEditingController();
  TextEditingController edit8 = TextEditingController();
  TextEditingController edit9 = TextEditingController();
  TextEditingController edit10 = TextEditingController();
  List<ActivityModel> activityModel = [];
  Map arguments = Map();
  List categoryItemlist = [];
  List categoryItemlistdiesease = [];
  List categoryItemlistbug = [];
  List<CropModel> cropModel = [];
  List<DieseaseModel> dieseaseModel = [];
  List<bugModel> BugModel = [];
  // TextEditingController greenhousenumber = TextEditingController();

  String data_ID = "";
  @override
  void initState() {
    getdata_by_id();
    getcrop();
    getdiesease();
    getbug();
    super.initState();
  }

  var dropdownvalue;
  var dropdownvaluediesease;
  var dropdownvaluebug;
  var valuedate;
  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['activity_id']);
    data_ID = arguments['activity_id'];
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
                'แก้ไขข้อมูลผลผลิต',
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
              "แก้ไขข้อมูลผลผลิต",
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
          input_activity_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_crop_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_work_date(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_work_detail(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_problem(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_cost(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_diesease_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_bug_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_solve_by(),
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
                    MaterialPageRoute(builder: (value) => Show_activity());
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
  gettextdata(
    String? ID, {
    String? crop_id,
    work_date,
    work_detail,
    problem,
    cost,
    diesease_id,
    bug_id,
    solve_by,
    activity_id,
  }) async {
    setState(() {
      data_IDa = ID ?? '';
      edit2.text = crop_id ?? '';
      edit3.text = work_date ?? '';
      edit4.text = work_detail ?? '';
      edit5.text = problem ?? '';
      edit6.text = cost ?? '';
      edit7.text = diesease_id ?? '';
      edit8.text = bug_id ?? '';
      edit9.text = solve_by ?? '';
      edit10.text = activity_id ?? '';
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

//////////////////////////////////////////////getCrop////////////////////////////////
  bool readdata = false;
  Future<Null> getcrop() async {
    // Showlist();
    cropModel.clear();
    print(cropModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getCrop.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    print('===>$response');
    var result = json.decode(response.data);
    print(result.toString());
    if (result.toString() != 'null') {
      //print(result.toString());
      for (var map in result) {
        CropModel cropModels = CropModel.fromJson(map);
        setState(() {
          cropModel.add(cropModels);
          readdata = true;
          readdata = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlist = jsonData;
            });
          }
        });
      }
      //print(jsonEncode(Model));
    } else {
      setState(() {
        cropModel = [];
        readdata = false;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////getactivity//////////////////////////////////////////
  bool readdata1 = false;
  Future<Null> getdiesease() async {
    dieseaseModel.clear();
    print(dieseaseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getdiesease.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsegh_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        DieseaseModel dieseaseModels = DieseaseModel.fromJson(map);
        setState(() {
          dieseaseModel.add(dieseaseModels);
          readdata1 = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistdiesease = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        dieseaseModel = [];
        readdata1 = false;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  bool readdatabug = false;
  Future<Null> getbug() async {
    BugModel.clear();
    print(BugModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getbug.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsebug==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        bugModel BugModels = bugModel.fromJson(map);
        setState(() {
          BugModel.add(BugModels);
          readdatabug = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistbug = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        BugModel = [];
        readdatabug = false;
      });
    }
  }

///////////////////////////////////////////////////////////////////////////////
  Future<Null> getdata_by_id() async {
    activityModel.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/GetEditactivity.php?activity_id=${data_ID}&isAdd=item';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      data_IDa = data_ID;
      edit2.text = result['crop_id'];
      edit3.text = result['work_date'];
      edit4.text = result['work_detail'];
      edit5.text = result['problem'];
      edit6.text = result['cost'];
      edit7.text = result['diesease_id'];
      edit8.text = result['bug_id'];
      edit9.text = result['solve_by'];
      edit10.text = result['activity_id'];
    });
  }

  Future<Null> editdata() async {
    final crop_id = edit2.text,
        work_date = edit3.text,
        work_detail = edit4.text,
        problem = edit5.text,
        cost = edit6.text,
        diesease_id = edit7.text,
        bug_id = edit8.text,
        solve_by = edit9.text,
        activity_id = edit10.text;
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/edit_activity.php?isAdd=true&activity_id=$data_ID&crop_id=$dropdownvalue&work_date=$valuedate&work_detail=$work_detail&problem=$problem&cost=$cost&diesease_id=$dropdownvaluediesease&bug_id=$dropdownvaluebug&solve_by=$solve_by';
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
          data_IDa = '';
        });
      } else if (value.toString() == 'havedata') {
        normalDialog(context, 'มีไอดีนี้อยู่แล้วกรุณาลองใหม่');
      } else {
        // normalDialog(context, 'กรุณาลองใหม่ มีอะไร? ผิดพลาด');
      }
    });
  }

  // Widget input_crop_id() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit2,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'รหัสฟร์าม :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_crop_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสรอบการปลูก',
              style: TextStyle(
                  fontSize: 14,
                  // color: Theme.of(context).hintColor,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            items: categoryItemlist.map((item) {
              return DropdownMenuItem(
                value: item['crop_id'].toString(),
                child: Text(item['crop_id'].toString()),
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
              // print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );

  Widget input_activity_id() => Container(
        width: 250.0,
        child: TextField(
          controller: edit10,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสวันที่บันทึก :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  // Widget input_work_date() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit3,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'วันที่บันทึก :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_work_date() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            DateTimeFormField(
                dateFormat: DateFormat('dd/MM/yyyy'),
                decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'วันที่บันทึก',
              ),
               firstDate: DateTime(0000),
              lastDate: DateTime(9999),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.always,
              validator: (DateTime? e) =>
                  (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                print(value.toString());
                setState(() {
                  valuedate = value.toString();
                });
              },
            ),
          ],
        ),
      );
  Widget input_work_detail() => Container(
        width: 250.0,
        child: TextField(
          controller: edit4,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รายละเอียด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_problem() => Container(
        width: 250.0,
        child: TextField(
          controller: edit5,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ปัญหาที่พบ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_cost() => Container(
        width: 250.0,
        child: TextField(
          controller: edit6,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ค่าใช้จ่าย :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  // Widget input_diesease_id() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit7,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'รหัสโรค :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_diesease_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสโรค',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistdiesease.map((item1) {
              return DropdownMenuItem(
                value: item1['diesease_id'].toString(),
                child: Text(item1['diesease_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluediesease,
            onChanged: (newValue) {
              setState(() {
                dropdownvaluediesease = newValue as String;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );
  // Widget input_bug_id() => Container(
  //       width: 250.0,
  //       child: TextField(
  //         controller: edit8,
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().textColor),
  //           labelText: 'รหัสศัตรูพืช :',
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //         ),
  //       ),
  //     );
  Widget input_bug_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสศัตรูพืช',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistbug.map((itembug) {
              return DropdownMenuItem(
                value: itembug['bug_id'].toString(),
                child: Text(itembug['bug_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluebug,
            onChanged: (newValue) {
              setState(() {
                dropdownvaluebug = newValue as String;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );
  Widget input_solve_by() => Container(
        width: 250.0,
        child: TextField(
          controller: edit9,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'การแก้ไขปัญหา :',
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
