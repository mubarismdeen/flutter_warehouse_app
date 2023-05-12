import 'package:admin/constants/style.dart';
import 'package:admin/models/docDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import 'custom_date_picker.dart';

class DocDetailsUpload extends StatefulWidget {
  const DocDetailsUpload({Key? key}) : super(key: key);

  @override
  State<DocDetailsUpload> createState() => _DocDetailsUploadState();
}

class _DocDetailsUploadState extends State<DocDetailsUpload> {
  final _formKey = GlobalKey<FormState>();

  var _narration = TextEditingController();
  var _document = TextEditingController();
  var _dueDate = TextEditingController();
  var _renewedDate = TextEditingController();
  var dateCtl = TextEditingController();
  var _docTypeValue = '';

  // void onDateChange(DateTime newDate) {
  //   setState(() {
  //     _renewedDate = newDate;
  //   });
  // }

  List<Map<String, dynamic>> docTypes = <Map<String, dynamic>>[];

  getDocTypes() async {
    docTypes = await getDocType();
  }

  DocDetails _docDetails = DocDetails(
      id: 0,
      narration: "",
      docType: "",
      dueDate: DateTime.now(),
      renewedDate: DateTime.now(),
      creatBy: "",
      creatDt: DateTime.now(),
      editBy: "",
      editDt: DateTime.now());

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // Submit the form data to a backend API or do something else with it
      print('Submitted form data:');
      print('Name: $_narration');
      print('Document: $_document');
      print('Due Date: $_dueDate');
      print('Renewed Date: $_renewedDate');
    }
    _docDetails.narration = _narration.text;
    _docDetails.docType = _document.text;
    _docDetails.dueDate = DateTime.parse(_dueDate.text);
    _docDetails.renewedDate = DateTime.parse(_renewedDate.text);

    bool status = await saveDocDetails(_docDetails);
    if (status) {
      Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition: "center",
        webShowClose: false,
      );
      _narration.clear();

      _document.clear();

      _dueDate.clear();

      // _renewedDate.clear();

      setState(() {});
      // _salaryMaster = SalaryMaster as SalaryMaster;
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "failed to save",
          message: '',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getDocTypes(),
        builder: (context, AsyncSnapshot<dynamic> _data) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    controller: _narration,
                    onSaved: (value) {},
                  ),
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(labelText: 'Document Type'),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter document type';
                  //     }
                  //     return null;
                  //   },
                  //   controller: _document,
                  //   onSaved: (value) {
                  //     // _preFixedMonthlySalary = double.parse(value!);
                  //   },
                  // ),
                  // DropdownMenu(dropdownMenuEntries: docTypes.map((dType) => dType['description']).toList()),
                  // DropdownButton<String>(
                  //   value: docTypes.first['description'].toString(),
                  //   icon: const Icon(Icons.arrow_downward),
                  //   elevation: 16,
                  //   isExpanded: true,
                  //   // style: const TextStyle(color: Colors.deepPurple),
                  //   // underline: Container(
                  //   //   height: 2,
                  //   //   color: Colors.deepPurpleAccent,
                  //   // ),
                  //   onChanged: (String? value) {
                  //     setState(() {
                  //       _docTypeValue = value!;
                  //     });
                  //   },
                  //   items:
                  //       docTypes.map<DropdownMenuItem<String>>((dynamic value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value['description'].toString(),
                  //       child: Text(value['description']),
                  //     );
                  //   }).toList(),
                  // ),
                  DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'Please select document type';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Doc Type'),
                      items: docTypes
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['description'].toString(),
                          child: Text(value['description']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _docTypeValue = value!;
                        });
                      }),
                  TextFormField(
                    controller: _dueDate,
                    decoration: const InputDecoration(labelText: 'Due Date'),
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(FocusNode());
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        _dueDate.text = DateFormat('yyyy-MM-dd').format(date);
                      }
                    },
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Please select Due Date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _renewedDate,
                    decoration:
                        const InputDecoration(labelText: 'Renewed Date'),
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(FocusNode());
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        _renewedDate.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      }
                    },
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Please select Renewed Date';
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(labelText: 'Due Date'),
                  //   keyboardType: TextInputType.datetime,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter Due Date';
                  //     }
                  //     if (DateTime.tryParse(value) == null) {
                  //       return 'Please enter a valid date';
                  //     }
                  //     return null;
                  //   },
                  //   controller: _dueDate,
                  //   onSaved: (value) {
                  //     // _normalOvertimeRate = double.parse(value!);
                  //   },
                  // ),
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(labelText: 'Renewed Date'),
                  //   keyboardType: TextInputType.datetime,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter Renewed Date';
                  //     }
                  //     if (DateTime.tryParse(value) == null) {
                  //       return 'Please enter a valid date';
                  //     }
                  //     return null;
                  //   },
                  //   controller: _renewedDate,
                  //   onSaved: (value) {
                  //     // _specialOvertimeRate = double.parse(value!);
                  //   },
                  // ),
                  // CustomDatePicker(DateTime.now(), onDateChange),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                        ),
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
