import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CheckStatusHelper {
  Widget checkStatusBaru(int? status) {
    switch (status) {
      case 0:
        return Row(
          children: [
            Icon(Icons.check),
            Text(
              Constants.approve,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.green,
              ),
            )
          ],
        );
      case 2:
        return Row(
          children: [
            Icon(Icons.close),
            Text(
              Constants.reject,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.secondary,
              ),
            )
          ],
        );
      case 3:
      default:
        return Row(
          children: [
            Icon(Icons.pending),
            Text(
              Constants.pending,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.gray,
              ),
            )
          ],
        );
    }
  }

  Widget checkStatus(String status) {
    switch (status) {
      case Constants.approve:
        return Row(
          children: [
            Icon(Icons.check),
            Text(
              Constants.approve,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.green,
              ),
            )
          ],
        );
      case Constants.reject:
        return Row(
          children: [
            Icon(Icons.close),
            Text(
              Constants.reject,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.secondary,
              ),
            )
          ],
        );
      case Constants.pending:
      default:
        return Row(
          children: [
            Icon(Icons.pending),
            Text(
              Constants.pending,
              style: LaporanCheckTextStyle.bodyText2.copyWith(
                color: LaporanCheckColors.gray,
              ),
            )
          ],
        );
    }
  }
}
