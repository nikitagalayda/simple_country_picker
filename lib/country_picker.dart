import 'package:flutter/material.dart';

import './countries_dialog.dart';
import './country.dart';

class CountryPicker extends StatefulWidget {
  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Country _selectedCountry = new Country(name: '', isoCode: '');

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          Text(_selectedCountry.name),
          RaisedButton(
            onPressed: () => askCountry(context),
            child: Text("COUNTRY"),
          ),
        ],
      ),
    );
  }

  Future<Country> askCountry(BuildContext ctx) async {
    Country newCountry = await showDialog<Country>(
        context: ctx,
        builder: (BuildContext context) {
          return CountriesDialog();
        });
    if (newCountry != null) {
      setState(() {
        _selectedCountry = newCountry;
      });
    }
  }
}
