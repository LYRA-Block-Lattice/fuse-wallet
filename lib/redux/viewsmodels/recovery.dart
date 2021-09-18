import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class RecoveryViewModel {
  final Function(
    String,
    VoidCallback successCallback,
    VoidCallback failureCallback,
  ) generateWalletFromBackup;

  RecoveryViewModel({
    required this.generateWalletFromBackup,
  });

  static RecoveryViewModel fromStore(Store<AppState> store) {
    return RecoveryViewModel(
      generateWalletFromBackup: (
        mnemonic,
        VoidCallback successCallback,
        VoidCallback failureCallback,
      ) {
        if (mnemonic.trim().contains(' ')) {
          store.dispatch(
            restoreWalletCall(
              mnemonic.toLowerCase().split(' ').toList(),
              successCallback,
              failureCallback,
            ),
          );
        } else {
          store.dispatch(
            restoreWalletByPrivateKeyCall(
              mnemonic,
              successCallback,
              failureCallback,
            ),
          );
        }
      },
    );
  }
}
