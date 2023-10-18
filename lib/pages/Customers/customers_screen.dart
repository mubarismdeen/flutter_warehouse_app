import 'package:admin/api.dart';
import 'package:admin/constants/style.dart';
import 'package:admin/models/customerDetails.dart';
import 'package:admin/widget/customer_details_form.dart';
import 'package:admin/widget/custom_alert_dialog.dart';
import 'package:admin/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/privilege_constants.dart';
import '../../constants/controllers.dart';
import '../../globalState.dart';
import '../../helpers/responsiveness.dart';
import '../../models/userPrivileges.dart';
import '../../utils/common_utils.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<CustomerDetails> _customerDetails = List<CustomerDetails>.empty();
  UserPrivileges privileges = UserPrivileges(userId: 0, privilegeName: "", creatBy: "", creatDt: DateTime.now());

  getTableData() async {
    _customerDetails = await getCustomerDetails();
    List<UserPrivileges> customerScreenPrivileges = await getAPrivilegeForUser(
        GlobalState.username, customerDetailsScreenPrivilege);
    if (customerScreenPrivileges.isNotEmpty) {
      privileges = customerScreenPrivileges.first;
    }
  }

  closeDialog() {
    setState(() {
      getTableData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getTableData(),
        builder: (context, AsyncSnapshot<dynamic> _data) {
          return SingleChildScrollView(
            child: Column(children: [
              Obx(() => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6,
                            left: 10),
                        child: CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )),
              if (privileges.addPrivilege)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 35.0, top: 35.0),
                      child: _uploadButton(privileges),
                    ),
                  ],
                ),
              Padding(
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
                              showCheckboxColumn: false,
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
                              rows: _customerDetails
                                  .map((customer) => DataRow(
                                          cells: [
                                            DataCell(Text(customer.name)),
                                            DataCell(Text(customer.address)),
                                            DataCell(Text(customer.mobile1)),
                                            DataCell(Text(customer.mobile2)),
                                            DataCell(Text(
                                                customer.creatBy)),
                                            DataCell(Text(
                                                getDateStringFromDateTime(
                                                    customer.creatDt))),
                                          ],
                                          onSelectChanged: (selected) {
                                            if (selected != null && selected &&
                                                (privileges.editPrivilege ||
                                                    privileges.deletePrivilege)) {
                                              _openDialog(customer, privileges);
                                            }
                                          }))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }

  void _openDialog(CustomerDetails? tableRow, UserPrivileges privileges) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: 'Add New Customer',
            child: CustomerDetailsForm(closeDialog, tableRow, privileges),
        );
      },
    );
  }

  Widget _uploadButton(UserPrivileges privileges) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: themeColor,
      ),
      onPressed: () => _openDialog(null, privileges),
      child: const Text('Add Customer',
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
