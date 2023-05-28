import 'package:admin/constants/style.dart';
import 'package:admin/models/stockDetails.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:flutter/material.dart';

class StockTable extends StatefulWidget {
  @override
  _StockTableState createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {
  // List<StockDetails> _stockDetails = List<StockDetails>.empty();
  List<StockDetails> _stockDetails = [
    StockDetails(productCode: 1, name: 'tomato', type: 'vegetable', unit: 'kg', quantity: 10, price: 5, value: 50),
    StockDetails(productCode: 2, name: 'apple', type: 'fruit', unit: 'kg', quantity: 20, price: 15, value: 300),
    StockDetails(productCode: 3, name: 'pencil', type: 'stationary', unit: 'nos', quantity: 100, price: 10, value: 1000),
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
                                'Product\nID',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Product\nName',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Product\nType',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Unit',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Quantity',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Price',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Value',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: _stockDetails
                            .map((product) => DataRow(cells: [
                          DataCell(Text(product.productCode.toString())),
                          DataCell(Text(product.name)),
                          DataCell(Text(product.type)),
                          DataCell(Text(product.unit)),
                          DataCell(Text(product.quantity.toString())),
                          DataCell(Text(product.price.toString())),
                          DataCell(Text(product.value.toString())),
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
