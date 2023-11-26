import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../Utils/lib_organizer.dart';
import '../../Utils/range_list.dart';


class GetMapData extends StatefulWidget {
  const GetMapData({Key? key}) : super(key: key);

  @override
  State<GetMapData> createState() => _GetMapDataState();
}

class _GetMapDataState extends State<GetMapData> {
  final _formKey = GlobalKey<FormState>();


  var date = TextEditingController();

  String selectedCountry = 'ABW - Aruba';
  String selectedRange = '1'; // Initial selection


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      alignment: Alignment.centerLeft),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Area Map Data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: ThemeManager.textColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFieldComponent(
                                labelText: 'Date',
                                hintText: 'YYYY-MM-DD',
                                controller: date,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButton<String>(
                            value: selectedCountry,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountry = newValue.toString();
                              });
                            },
                            items: countries.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(fontSize: 10),),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButton<String>(
                            value: selectedRange,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRange = newValue.toString();
                              });
                            },
                            items: rangeList.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
,
                           SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await validateAndSubmit(context)
                                      .whenComplete(() {
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(vertical: 15)),
                                    backgroundColor: MaterialStateProperty.all(
                                       ThemeManager.accent)),
                                child: const Text('View Data',style: TextStyle(
                                  color: Colors.white
                                ),)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      List<String> mapValues = [];
      mapValues.add(date.text.trim());
      mapValues.add(selectedCountry.split("-")[0].trim());
      mapValues.add(selectedRange.trim());
     //add validation
      Navigator.of(context).pushNamed(getMapRoute,arguments: mapValues);
    }
  }
}

