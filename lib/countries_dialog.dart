import 'package:flutter/material.dart';

import './country.dart';
import './county_codes.dart';

class CountriesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Container(
      child: SimpleDialog(
        children: <Widget>[
          Container(
            height: mediaQuery.height * 0.7,
            width: mediaQuery.width * 0.7,
            child: ListView.builder(itemCount: countries.length, itemBuilder: (BuildContext context, int index) {
              Country country = countries[index];
              return FlatButton(onPressed: () {}, child: Text(country.name),);
            })
              
              // <Widget>[
              //   // Text(_selectedCountry ),
              //   RaisedButton(onPressed: () {
              //     Navigator.pop(context, "RETURN VAL");
              //   }, child: Text("CLICK"),),
              // ],
            // ),
          ),
        ],
      ),
    );
  }
}