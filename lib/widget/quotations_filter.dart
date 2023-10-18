import 'package:admin/constants/style.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../models/customerDetails.dart';

class QuotationsFilter extends StatefulWidget {
  dynamic applyFilter;
  QuotationsFilter(this.applyFilter, {Key? key}) : super(key: key);

  @override
  State<QuotationsFilter> createState() => _QuotationsFilterState();
}

class _QuotationsFilterState extends State<QuotationsFilter> {
  final _formKey = GlobalKey<FormState>();

  var _name = TextEditingController();

  String _selectedCustomerName = '';
  String _selectedName = '';
  String _selectedPoStatus = '';
  String _selectedInvoiceStatus = '';
  String _selectedType = '';

  List<Map<String, dynamic>> invoiceStatuses = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> poStatuses = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> types = <Map<String, dynamic>>[];
  List<CustomerDetails> customers = <CustomerDetails>[];

  getDropdownInputs() async {
    invoiceStatuses = await getInvoiceStatus();
    poStatuses = await getPoStatus();
    types = await getQuotationType();
    customers = await getCustomerDetails();
  }

  Future<void> _applyForm() async {
    _selectedName = _name.text;
    widget.applyFilter(_selectedCustomerName, _selectedName, _selectedPoStatus, _selectedInvoiceStatus, _selectedType);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getDropdownInputs(),
        builder: (context, AsyncSnapshot<dynamic> _data) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'Customer'),
                      items: customers.map<DropdownMenuItem<String>>(
                          (CustomerDetails customer) {
                        return DropdownMenuItem<String>(
                          value: customer.name,
                          child: Text(customer.name),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCustomerName = value??'';
                        });
                      }),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Vessel'),
                    controller: _name,
                    onSaved: (value) {},
                  ),
                  DropdownButtonFormField(
                      decoration:
                          const InputDecoration(labelText: 'Type'),
                      items:
                          types.map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['description'].toString(),
                          child: Text(value['description']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedType = types.firstWhere(
                              (type) => type['description'] == value)['id'].toString();
                        });
                      }),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'PO Status'),
                      items: poStatuses
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['description'].toString(),
                          child: Text(value['description']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPoStatus = poStatuses.firstWhere(
                              (poStatus) => poStatus['description'] == value)['id'].toString();
                        });
                      }),
                  DropdownButtonFormField(
                      decoration:
                          const InputDecoration(labelText: 'Invoice Status'),
                      items: invoiceStatuses
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value['description'].toString(),
                          child: Text(value['description']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedInvoiceStatus = invoiceStatuses.firstWhere(
                              (invStatus) => invStatus['description'] == value)['id'].toString();
                        });
                      }),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                        ),
                        onPressed: _applyForm,
                        child: const Text('Apply'),
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
