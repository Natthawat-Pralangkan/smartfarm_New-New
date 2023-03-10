import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';

class Infarm extends StatefulWidget {
  const Infarm({Key? key}) : super(key: key);
  @override
  _farm createState() => _farm();
}

class _farm extends State<Infarm> {
  String? farm_id,
      farm_name,
      address,
      tumbon,
      amphur,
      province,
      email,
      password,
      typeuser,
      lat,
      Lng;

  @override
  void initState() {
    var initState = super.initState();
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
          input_farm_name(),
          input_address(),
          input_tumbon(),
          input_amphur(),
          input_province(),
          input_email(),
          input_password(),
          input_typeuser(),
          input_lat(),
          input_Lng(),
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
                    'farm_id=$farm_id,farm_name=$farm_name,address=$address,tumbon=$tumbon,amphur=$amphur,province=$province,email=$email,password=$password,typeuser=$typeuser,lat=$lat,Lng=$Lng');
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, '???????????????????????????ID');
                  return;
                }
                if (farm_name == null || farm_name == '') {
                  normalDialog(context, '??????????????????????????????????????????????????????');
                  return;
                }
                if (address == null || address == '') {
                  normalDialog(context, '????????????????????????????????????????????????');
                  return;
                }
                if (tumbon == null || tumbon == '') {
                  normalDialog(context, '???????????????????????????????????????');
                  return;
                }
                if (amphur == null || amphur == '') {
                  normalDialog(context, '??????????????????????????????????????????');
                  return;
                }
                if (province == null || province == '') {
                  normalDialog(context, '????????????????????????????????????????????????');
                  return;
                }
                if (email == null || email == '') {
                  normalDialog(context, '??????????????????????????????????????????');
                  return;
                }
                if (password == null || password == '') {
                  normalDialog(context, '???????????????????????????????????????????????????');
                  return;
                }
                if (typeuser == null || typeuser == '') {
                  normalDialog(context, '?????????????????????????????????????????????');
                  return;
                }
                if (lat == null || lat == '') {
                  normalDialog(context, '????????????????????????????????????????????????');
                  return;
                }
                if (Lng == null || Lng == '') {
                  normalDialog(context, '???????????????????????????????????????????????????');
                  return;
                }

                if (farm_id == null ||
                    farm_name == null ||
                    address == null ||
                    tumbon == null ||
                    amphur == null ||
                    province == null ||
                    email == null ||
                    password == null ||
                    typeuser == null ||
                    lat == null ||
                    Lng == null ||
                    farm_id == '' ||
                    farm_name == '' ||
                    address == '' ||
                    tumbon == '' ||
                    amphur == '' ||
                    province == '' ||
                    email == '' ||
                    password == '' ||
                    typeuser == '' ||
                    lat == '' ||
                    Lng == '') {
                  normalDialog(context, '????????????????????????????????????????????????????????????????????????????????????');
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
                '???????????????????????????',
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
        'http://chiangraismartfarm.com/APIsmartfarm/insert_farm.php?isAdd=true&farm_id=$farm_id&farm_name=$farm_name&address=$address&tumbon=$tumbon&amphur=$amphur&province=$province&email=$email&password=$password&typeuser=$typeuser&lat=$lat&Lng=$Lng';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(
            context, '??????????????????????????? $farm_id ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????');
      } else {
        Navigator.pop(context);
        normalDialog(context, '??????????????????????????????????????????????????????????????????');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget input_farm_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => farm_id = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '??????????????????????????? :',
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
          onChanged: (value) => farm_name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '??????????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

//================= ?????????????????????????????? Field =============
  Widget input_address() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => address = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
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
          onChanged: (value) => tumbon = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '???????????? :',
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
          onChanged: (value) => amphur = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '??????????????? :',
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
          onChanged: (value) => province = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
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
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '?????????????????? :',
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
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '???????????????????????? :',
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
          onChanged: (value) => typeuser = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '?????????????????? :',
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
          onChanged: (value) => lat = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
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
          onChanged: (value) => Lng = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '???????????????????????? :',
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
