import 'package:admin/constants/style.dart';
import 'package:admin/models/salesDetails.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesTable extends StatefulWidget {
  @override
  _SalesTableState createState() => _SalesTableState();
}

class _SalesTableState extends State<SalesTable> {
  // List<StockDetails> _stockDetails = List<StockDetails>.empty();
  List<SalesDetails> _salesDetails = [
    SalesDetails(saleId: 1, customerName: 'ABC Mart', amount: 100, tax: 10, saleDt: DateTime.now()),
    SalesDetails(saleId: 2, customerName: 'DEF Pharma', amount: 200, tax: 20, saleDt: DateTime.now()),
    SalesDetails(saleId: 3, customerName: 'GHI Store', amount: 300, tax: 30, saleDt: DateTime.now()),
  ];

  getData() async {
    // _stockDetails =
    // await getSalaryMaster(DateFormat('yyyy-MM').format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, AsyncSnapshot<dynamic> _data) {
          return ConstrainedBox(
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
                                'Sale\nID',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Customer\nName',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Amount',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Tax',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Date',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: _salesDetails
                            .map((sale) => DataRow(cells: [
                          DataCell(Text(sale.saleId.toString())),
                          DataCell(Text(sale.customerName)),
                          DataCell(Text(sale.amount.toString())),
                          DataCell(Text(sale.tax.toString())),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(sale.saleDt))),
                        ]))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
