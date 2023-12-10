import 'package:admin/constants/style.dart';
import 'package:admin/models/customerDetails.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:flutter/material.dart';

class CustomerDetailsWidget extends StatefulWidget {
  List<CustomerDetails> customerDetails;
  CustomerDetailsWidget(this.customerDetails);

  @override
  _CustomerDetailsWidgetState createState() => _CustomerDetailsWidgetState();
}

class _CustomerDetailsWidgetState extends State<CustomerDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 600),
        child: getCustomCard(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Customer Name',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Address',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Mobile 1',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Mobile 2',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Created By',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Created Date',
                            style: tableHeaderStyle,
                          ),
                        ),
                      ),
                    ],
                    rows: widget.customerDetails
                        .map((customer) => DataRow(cells: [
                              DataCell(Text(customer.name)),
                              DataCell(Text(customer.address)),
                              DataCell(Text(customer.mobile1)),
                              DataCell(Text(customer.mobile2)),
                              DataCell(Text(customer.createBy)),
                              DataCell(Text(
                                  getDateStringFromDateTime(customer.createDate))),
                            ]))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
