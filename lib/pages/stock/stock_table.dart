import 'package:admin/api.dart';
import 'package:admin/constants/style.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../models/stock.dart';

class StockTable extends StatefulWidget {
  @override
  _StockTableState createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {
  List<Stock> _totalStock = List.empty();

  getData() async {
    _totalStock = await getTotalStock();
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
                                'Batch\nCode',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Product\nCode',
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
                                'Unit\nCost',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Unit\nPrice',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Edit\nBy',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Edit\nDate',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Create\nBy',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Create\nDate',
                                style: tableHeaderStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: _totalStock
                            .map((stock) => DataRow(cells: [
                          DataCell(Text(stock.batchCode)),
                          DataCell(Text(stock.productCode)),
                          DataCell(Text(stock.productName)),
                          DataCell(Text(stock.unit)),
                          DataCell(Text(stock.quantity.toString())),
                          DataCell(Text(stock.unitCost.toString())),
                          DataCell(Text(stock.unitPrice.toString())),
                          DataCell(Text(stock.editBy)),
                          DataCell(Text(getDateTimeString(stock.editDate))),
                          DataCell(Text(stock.createBy)),
                          DataCell(Text(getDateTimeString(stock.createDate))),
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
