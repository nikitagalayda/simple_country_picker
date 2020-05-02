import 'package:flutter/material.dart';

import './countries_dialog.dart';

class CountryPicker extends StatefulWidget {
  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String _selectedCountry = null;
  String _val = "old val";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          Text(_val),
          RaisedButton(onPressed: () => askCountry(context), child: Text("COUNTRY"),),
        ],
      ),
    );
  }

  Future<String> askCountry(BuildContext ctx ) async {
    String newVal = await showDialog<String>(context: ctx, builder: (BuildContext context) {
      return CountriesDialog();
    });
    setState(() {
      _val = newVal;
    });
  }
}
