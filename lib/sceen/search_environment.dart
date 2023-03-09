import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:smartfarm/model/environmentModel.dart';

class Search_environment extends StatefulWidget {
  const Search_environment({super.key});

  @override
  State<Search_environment> createState() => _Search_environmentState();
}

class _Search_environmentState extends State<Search_environment> {
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  List<Environment> userrmodel = [];
  List<Environment> user1model = [];
  bool load = false;
  String? farm_id, farm_name, email;
  bool havedata = false;

  @override
  void initState() {
    super.initState();
    getName().catchError((error) {
      print('getuser error ===>> $error');
    });
  }

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    farm_name = preferences.getString('farm_name');
    email = preferences.getString('email');
    getuser(farm_id!).catchError((error) {
      print('getuser error ===>> $error');
    });
  }

  Future getuser(String farm_id) async {
    if (mounted) {
      String url =
          'http://chiangraismartfarm.com/APIsmartfarm/environment.php?isAdd=true&farm_id=${farm_id}';
      await Dio().get(url).then(
        (value) {
          if (value.toString() == 'null') {
          } else {
            print(value.data);
            for (var item in json.decode(value.data)) {
              Environment setusermodel = Environment.fromMap(item);
              print('==>> ${setusermodel.datekey}');
              userrmodel.add(setusermodel);
              user1model.add(setusermodel);
            }
            user1model = userrmodel
                .where((r) => (r.datekey
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase())))
                .toList();
            havedata = true;
          }
          load = true;
          if (mounted) {
            setState(() {});
          }
        },
      ).catchError((error) {
        print('getuser error ===>> $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 53, 235, 86),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: 300,
                    height: 80,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: searchController,
                      onChanged: (value) {
                        if (mounted) {
                          user1model = userrmodel
                              .where((r) => (r.datekey
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                              .toList();
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorWidth: 1.5,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'search',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'search',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        suffixIcon: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              searchController.text.isEmpty
                                  ? SizedBox()
                                  : IconButton(
                                      onPressed: () async {
                                        if (mounted) {
                                          searchController.clear();
                                          user1model = userrmodel;
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )),
                              IconButton(
                                  onPressed: () async {
                                    if (mounted) {
                                      DateTime? sdsd = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(0000),
                                        lastDate: DateTime(9999),
                                      );
                                      if (sdsd == null) {
                                      } else {
                                        String dsd = DateFormat('yyyy-MM-dd')
                                            .format(sdsd);

                                        user1model = userrmodel
                                            .where((r) => (r.datekey
                                                .toLowerCase()
                                                .contains(dsd
                                                    .toString()
                                                    .toLowerCase())))
                                            .toList();
                                        searchController.text = dsd;
                                      }

                                      if (mounted) {
                                        setState(() {});
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: load == false
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : havedata == false
                        ? Center(
                            child: Text(
                              'no data',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : ListView.builder(
                            itemCount: user1model.length,
                            itemBuilder: (context, index) => Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   user1model[index].crop_id,
                                          //   style:
                                          //       TextStyle(color: Colors.black),
                                          // ),
                                          Text(
                                            'รหัสฟร์าม' +
                                                ' ' +
                                                user1model[index].farm_id,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'เอกสาร' +
                                                ' ' +
                                                user1model[index].docno,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'รหัสอุปกรณ์' +
                                                ' ' +
                                                user1model[index].device_id,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'คีย์วันที่' +
                                                ' ' +
                                                user1model[index].datekey,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'ไทม์คีย์' +
                                                ' ' +
                                                user1model[index].timekey,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'อุณหภูมิ' +
                                                ' ' +
                                                user1model[index].temp,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'ความชื้น' +
                                                ' ' +
                                                user1model[index].humid,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'แสงสว่าง' +
                                                ' ' +
                                                user1model[index].light,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                             'ดิน_1' +
                                                ' ' +user1model[index].soild_1,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'ดิน_2' +
                                                ' ' +
                                                user1model[index].soild_2,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'เฟิร์น_n' +
                                                ' ' +
                                                user1model[index].fer_n,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'เฟิร์น_p' +
                                                ' ' +
                                                user1model[index].fer_p,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'เฟิร์น_k' +
                                                ' ' +
                                                user1model[index].fer_k,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'น้ำ_อุณหภูมิ' +
                                                ' ' +
                                                user1model[index].water_temp,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
