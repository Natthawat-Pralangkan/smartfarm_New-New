import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/CloseCropModel.dart';
import 'package:smartfarm/sceen/Show_bug.dart';
import 'package:intl/intl.dart';

class Search2 extends StatefulWidget {
  const Search2({super.key});

  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  List<CloseCropModel1> userrmodel = [];
  List<CloseCropModel1> user1model = [];
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
          'http://chiangraismartfarm.com/APIsmartfarm/getCloseCrop.php?isAdd=true&farm_id=${farm_id}';
      await Dio().get(url).then(
        (value) {
          if (value.toString() == 'null') {
          } else {
            print(value.data);
            for (var item in json.decode(value.data)) {
              CloseCropModel1 setusermodel = CloseCropModel1.fromMap(item);
              print('==>> ${setusermodel.crop_id}');
              userrmodel.add(setusermodel);
              user1model.add(setusermodel);
            }
            user1model = userrmodel
                .where((r) => (r.close_date
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
        backgroundColor: Colors.grey,
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
                              .where((r) => (r.close_date
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
                                            .where((r) => (r.close_date
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
                                            'รหัสฟร์าม' +' '+
                                                user1model[index].farm_id,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'วันที่เก็บเกี่ยว' +' '+ user1model[index].close_date,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'ต้นทุน'+' '+user1model[index].cost,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'รายได้'+user1model[index].amount,
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
