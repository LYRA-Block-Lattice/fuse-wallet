import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/app.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/language_selector.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int _key;

  void _changeLanguage(Locale _locale) async {
    MyApp.setLocale(context, _locale);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LanguageSelectorViewModel>(
      distinct: true,
      converter: LanguageSelectorViewModel.fromStore,
      builder: (_, viewModel) {
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: <Widget>[
              Flexible(
                child: SvgPicture.asset(
                  'assets/images/language.svg',
                  width: 13,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                I10n.of(context).language,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          children: _languageItems(viewModel),
        );
      },
    );
  }

  List<Widget> _languageItems(LanguageSelectorViewModel viewModel) {
    Locale currentLocal = Localizations.localeOf(context);
    return I10n.delegate.supportedLocales.map((locale) {
      bool isSelected = currentLocal == locale;
      Map code = codes.firstWhere((code) => code['code'] == locale.countryCode,
          orElse: () => null);
      String name = code['name'] ?? locale.countryCode;
      return ListTile(
        contentPadding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        title: Text(
          name,
        ),
        trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
        selected: isSelected,
        onTap: () {
          _changeLanguage(locale);
          viewModel.updateLocale(locale);
          setState(() {
            _collapse();
          });
        },
      );
    }).toList();
  }

  _collapse() {
    int newKey;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }
}
