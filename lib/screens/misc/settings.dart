import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/models/views/drawer.dart';
import 'package:roost/screens/home/router/home_router.gr.dart';
import 'package:roost/widgets/language_selector.dart';
import 'package:roost/widgets/main_scaffold.dart';
import 'package:roost/screens/routes.gr.dart';

class SettingsScreen extends StatelessWidget {
  Widget getListTile(
      BuildContext context, String label, void Function() onTap) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
      title: Text(
        label,
        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
      onTap: onTap,
    );
  }

  List<Widget> menuItem(BuildContext context, DrawerViewModel viewModel) {
    return [
      getListTile(context, I18n.of(context).about, () {
        ExtendedNavigator.named('homeRouter').push(HomeRoutes.aboutScreen);
      }),
      Divider(
        color: Color(0xFFE8E8E8),
      ),
      getListTile(context, I18n.of(context).protect_wallet, () {
        ExtendedNavigator.named('homeRouter')
            .push(HomeRoutes.protectYourWallet);
      }),
      Divider(
        color: Color(0xFFE8E8E8),
      ),
      LanguageSelector(),
      Divider(
        color: Color(0xFFE8E8E8),
      ),
      getListTile(context, I18n.of(context).logout, () {
        viewModel.logout();
        ExtendedNavigator.root.replace(Routes.splashScreen);
      })
    ];
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).settings,
            withPadding: true,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        children: <Widget>[...menuItem(context, viewModel)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
