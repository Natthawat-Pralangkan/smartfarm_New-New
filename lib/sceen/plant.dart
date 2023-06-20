import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/style/dialog.dart';
import '../style/mystyle.dart';

////////////////////// DropdownButton///////////////////////
// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
// void main() => runApp(const DropdownButtonApp());

// class DropdownButtonApp extends StatelessWidget {
//   const DropdownButtonApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('DropdownButton Sample')),
//         body: const Center(
//           child: DropdownButtonExample(),
//         ),
//       ),
//     );
//   }
// }

// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({super.key});

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

////////////////////// DropdownButton///////////////////////
class plant extends StatefulWidget {
  const plant({Key? key}) : super(key: key);
  @override
  _plant createState() => _plant();
}

class _plant extends State<plant> {
  String? plant_id,
      plant_name,
      age_min,
      age_max,
      int,
      ph_min,
      ph_max,
      temp_min,
      temp_max,
      soil_min,
      soil_max,
      light_min,
      light_max,
      humid_min,
      humid_max,
      Fertilizer,
      remark_crop,
      farm_id;
  TextEditingController farm_idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    farm_idController.text = farm_id!;
    if (mounted) {
      setState(() {});
    }
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
          input_id(),
          input_name(),
          inputAgeRange(),
          inputTemperatureRange(),
          inputHumidRange(),
          inputLightRange(),
          inputSoilRange(),
          inputPHRange(),
          inputFertilizer(),
          inputremark_crop(),
          signupbut(),
        ],
      ),
    );
  }

  Widget signupbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                print(
                    'farm_id=$farm_id,plant_id=$plant_id,plant_name=$plant_name,age_min=$age_min,age_max=$age_max,ph_min=$ph_min,ph_max=$ph_max,temp_max=$temp_max,temp_min=$temp_min,soil_max=$soil_max,soil_min=$soil_min,light_max=$light_max,light_min=$light_min,humid_min=$humid_min,humid_max=$humid_max,Fertilizer=$Fertilizer,farm_id=$farm_id');
                if (plant_id == null || plant_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
                }
                if (plant_name == null || plant_name == '') {
                  normalDialog(context, 'กรุณากรอกชื่อพืช');
                  return;
                }
                if (age_min == null || age_min == '') {
                  normalDialog(context, 'กรุณากรอกอายุพืช(วัน)');
                  return;
                }
                if (age_max == null || age_max == '') {
                  normalDialog(context, 'กรุณากรอกอายุพืช(วัน)');
                  return;
                }
                if (ph_min == null || ph_min == '') {
                  normalDialog(context, 'กรุณากรอก ค่าpH ต่ำสุด');
                  return;
                }
                if (ph_max == null || ph_max == '') {
                  normalDialog(context, 'กรุณากรอก ค่าpH สูงสุด ');
                  return;
                }
                if (soil_max == null || soil_max == '') {
                  normalDialog(context, 'กรุณากรอก ความชื้นในดินสูงสุด');
                  return;
                }
                if (soil_min == null || soil_min == '') {
                  normalDialog(context, 'กรุณากรอก ความชื้นในดินต่ำสุด');
                  return;
                }
                if (humid_max == null || humid_max == '') {
                  normalDialog(context, 'กรุณากรอก ความชื้นสัมพัทธ์สูงสุด');
                  return;
                }
                if (humid_min == null || humid_min == '') {
                  normalDialog(context, 'กรุณากรอก ความชื้นสัมพัทธ์ต่ำสุด');
                  return;
                }
                if (light_max == null || light_max == '') {
                  normalDialog(context, 'กรุณากรอก ช่วงแสงสูงสุด');
                  return;
                }
                if (light_min == null || light_min == '') {
                  normalDialog(context, 'กรุณากรอก ช่วงแสงต่ำสุด');
                  return;
                }
                if (temp_max == null || temp_max == '') {
                  normalDialog(context, 'กรุณากรอกอุณภูมิสูงสุด');
                  return;
                }
                if (temp_min == null || temp_min == '') {
                  normalDialog(context, 'กรุณากรอกอุณภูมิต่ำสุด');
                  return;
                }
                if (Fertilizer == null || Fertilizer == '') {
                  normalDialog(context, 'กรุณากรอกสูตรปุ๋ย');
                  return;
                }
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสฟร์าม');
                  return;
                } 
                else {
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
        'http://chiangraismartfarm.com/APIsmartfarm/insert_plant.php?isAdd=true&farm_id=$farm_id&plant_id=$plant_id&plant_name=$plant_name&age_min=$age_min&age_max=$age_max&ph_min=$ph_min&ph_max=$ph_max&temp_max=$temp_max&temp_min=$temp_min&soil_max=$soil_max&soil_min=$soil_min&light_max=$light_max&light_min=$light_min&humid_min=$humid_min&humid_max=$humid_max&fertilizer=$Fertilizer&remark_crop=$remark_crop';
    try {
      Response response = await Dio().get(url);
      print(response.statusCode);
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context, 'มีไอดีนี้แล้ว $plant_id ');
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
          autofocus: true,
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
  Widget input_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => plant_id = value.trim(),
          autofocus: true,
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

  Widget inputAgeRange() => Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => age_min = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อายุพืชต่ำสุด :',
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => age_max = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อายุพืชสูงสุด :',
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
  Widget input_name() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => plant_name = value.trim(),
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

  Widget inputremark_crop() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => remark_crop = value.trim(),
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
  ///////////////////////////////////////////////////////////////////////////////// PH
  Widget inputPHRange() => Row(
        children: [
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => ph_min = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่า ph ต่ำสุด:',
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => ph_max = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ค่า ph สูงสุด :',
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
////////////////////////////////////////////////////////////////////////////อุณหภูมิ
  Widget inputTemperatureRange() => Row(
        children: [
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => temp_min = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อุณหภูมิต่ำสุด :',
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => temp_max = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'อุณหภูมิสูงสุด :',
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
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => humid_min = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ความชื้นสัมพัทธ์ต่ำสุด :',
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => humid_max = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'ความชื้นสัมพัทธ์สูงสุด :',
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
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => light_min = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'แสงต่ำสุด :',
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => light_max = value.trim(),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: MyStyle().textColor),
                  labelText: 'แสงสูงสุด :',
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
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => soil_min = value.trim(),
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
          SizedBox(width: 10), // Add spacing between the inputs
          Expanded(
            child: Container(
              width: 250.0,
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) => soil_max = value.trim(),
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
  Widget inputFertilizer() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          onChanged: (value) => Fertilizer = value.trim(),
          autofocus: true,
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
}
