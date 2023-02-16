import 'package:flutter/material.dart';

import '../../../utils/check_status_helper.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref.dart';

class ItemAdmin extends StatelessWidget {
  const ItemAdmin({
    super.key,
    required this.nama,
    required this.onTap,
    this.statusApprove,
  });
  final String nama;
  final int? statusApprove;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // onTap: () {
        //   onTap();
        // },
        title: Row(
          children: [
            Text('$nama'),
            Text(' - '),
            CheckStatusHelper().checkStatusBaru(statusApprove)
          ],
        ),
        // trailing: CheckStatusHelper().checkStatus(Constants.reject),
        trailing: Prefs().role == 1
            ? SizedBox()
            : TextButton(
                onPressed: () {
                  onTap();
                },
                child: Text('Action')),
      ),
    );
  }
}
