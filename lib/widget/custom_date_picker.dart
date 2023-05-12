import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  DateTime pickedDate;
  void Function(DateTime newDate) onDateChange;

  CustomDatePicker(this.pickedDate, this.onDateChange);

  @override
  _CustomDatePickerState createState() =>
      _CustomDatePickerState(pickedDate, onDateChange);
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _dateTime;
  var _dateTimeController = TextEditingController();
  void Function(DateTime newDate) onDateChange;

  _CustomDatePickerState(this._dateTime, this.onDateChange);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: DateFormat('yyyy-MM-dd').format(_dateTime),
      // initialValue: DateFormat('yyyy-MM-dd').format(_dateTime) ==
      //         DateFormat('yyyy-MM-dd').format(DateTime.now())
      //     ? ' '
      //     : DateFormat('yyyy-MM-dd').format(_dateTime),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _dateTime,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null && picked != _dateTime) {
          setState(() {
            _dateTime = picked;
          });
          onDateChange(picked);
        }
      },
      decoration: const InputDecoration(labelText: 'Renewed Date'),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value!.isEmpty || DateTime.tryParse(value) == null) {
          return 'Please enter a valid date';
        }
        return null;
      },
      controller: _dateTimeController,
      onSaved: (value) {
        // _specialOvertimeRate = double.parse(value!);
      },
    );
  }
}
