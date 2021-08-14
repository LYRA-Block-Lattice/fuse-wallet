import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:country_code_picker/country_code.dart';

class SplashViewModel extends Equatable {
  final String privateKey;
  final String jwtToken;
  final bool isLoggedOut;
  final Function() loginAgain;
  final Function(
    CountryCode,
    String,
    VoidCallback loginFailureCallback,
  ) signUp;

  final Function(
    VoidCallback successCallback,
    VoidCallback errorCallback,
  ) createLocalAccount;

  SplashViewModel(
      {required this.privateKey,
      required this.jwtToken,
      required this.isLoggedOut,
      required this.createLocalAccount,
      required this.loginAgain,
      required this.signUp});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
      privateKey: store.state.userState.privateKey,
      jwtToken: store.state.userState.jwtToken,
      isLoggedOut: store.state.userState.isLoggedOut,
      createLocalAccount: (
        VoidCallback successCallback,
        VoidCallback errorCallback,
      ) {
        store.dispatch(
          createLocalAccountCall(
            successCallback,
            errorCallback,
          ),
        );
      },
      signUp: (
        CountryCode countryCode,
        String phoneNumber,
        VoidCallback loginFailureCallback,
      ) {
        store.dispatch(loginHandler(
          countryCode,
          phoneNumber,
          loginFailureCallback,
        ));
      },
      loginAgain: () {
        store.dispatch(reLoginCall());
      },
    );
  }

  @override
  List<Object> get props => [
        privateKey,
        jwtToken,
        isLoggedOut,
      ];
}
