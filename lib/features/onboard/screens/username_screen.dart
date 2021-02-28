import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class UserNameScreen extends StatelessWidget {
  onInit(store) {
    final String accountAddress = store.state.userState.accountAddress;
    store.dispatch(createAccountWalletCall(accountAddress));
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/user-name-screen');
    return MyScaffold(
      title: I18n.of(context).sign_up,
      body: StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        onInit: onInit,
        converter: OnboardViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 0,
                top: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SvgPicture.asset(
                      'assets/images/username.svg',
                      width: 95,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    I18n.of(context).pickup_display_name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    I18n.of(context).pickup_display_name_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 255,
                    color: Theme.of(context).canvasColor,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface),
                      autofocus: true,
                      onFieldSubmitted: (value) {
                        viewModel.setDisplayName((value ?? 'Anom'));
                        ExtendedNavigator.root.pushSecurityScreen();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                        fillColor: Theme.of(context).canvasColor,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      // decoration: InputDecoration(
                      //   border: UnderlineInputBorder(
                      //     borderSide: BorderSide(
                      //       width: 2,
                      //       color: Theme.of(context).colorScheme.onSurface,
                      //     ),
                      //   ),
                      //   focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(
                      //       width: 2,
                      //       color: Theme.of(context).colorScheme.onSurface,
                      //     ),
                      //   ),
                      // ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
