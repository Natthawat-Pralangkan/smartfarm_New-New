import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';

class greenhouse extends StatefulWidget {
  const greenhouse({Key? key}) : super(key: key);
  @override
  _greenhouse createState() => _greenhouse();
}

class _greenhouse extends State<greenhouse> {
  String? farm_id, gh_id, gh_name, gh_status;
  TextEditingController farm_idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 74, 216, 8),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
//MyStyle().showcrru(),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          input_farm_id(),
          input_gh_id(),
          input_gh_name(),
          input_gh_status(),
          signupbut(),
        ],
      ),
    );
  }

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    farm_idController.text = farm_id!;
    if (mounted) {
      setState(() {});
    }
  }

  Widget signupbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                print(
                    'farm_id=$farm_id,gh_id=$gh_id,gh_name=$gh_name,gh_status=$gh_status');
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสฟร์าม');
                  return;
                }
                if (gh_id == null || gh_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสโรงเรียน');
                  return;
                }
                if (gh_name == null || gh_name == '') {
                  normalDialog(context, 'กรุณากรอกชื่อโรงเรียน');
                  return;
                }
                if (gh_status == null || gh_status == '') {
                  normalDialog(context, 'กรุณากรอกสถานะ');
                  return;
                }
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                } else {
                  CheckUser();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: MyStyle().textColor,
                onPrimary: Colors.blueAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'บันทึกข้อมูล',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );

  Future<void> CheckUser() async {
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/insert_greenhouse.php?isAdd=true&farm_id=$farm_id&gh_id=$gh_id&gh_name=$gh_name&gh_status=$gh_status';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context, 'มีไอดีนี้แล้ว $farm_id ');
      } else {
        Navigator.pop(context);
        normalDialog(context, 'บันทึกข้อมูลเรียบร้อยแล้ว');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget input_farm_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: farm_idController,
          onChanged: (value) => farm_id = value.trim(),
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
  Widget input_gh_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => gh_id = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสโรงเรือน :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_gh_name() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => gh_name = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อโรงเรือน :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
Widget input_gh_status() => Container(
  width: 250.0,
  margin: const EdgeInsets.all(10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'สถานะ :',
        style: TextStyle(
          color: MyStyle().textColor,
        ),
      ),
      Row(
        children: [
          Radio<String>(
            value: '0',
            groupValue: gh_status,
            onChanged: (value) {
              setState(() {
                gh_status = value;
              });
            },
          ),
          Text('ว่าง'),
          Radio<String>(
            value: '1',
            groupValue: gh_status,
            onChanged: (value) {
              setState(() {
                gh_status = value;
              });
            },
          ),
          Text('ไม่ว่าง'),
        ],
      ),
    ],
  ),
);

}
