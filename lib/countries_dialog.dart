import 'package:flutter/material.dart';

import './country.dart';
import './county_codes.dart';

class CountriesDialog extends StatefulWidget {
  @override
  _CountriesDialogState createState() => _CountriesDialogState();
}

class _CountriesDialogState extends State<CountriesDialog> {

  List<Country> countryList;

  @override
  void initState() { 
    super.initState();
    countryList = countries;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Container(
      child: SimpleDialog(
        children: <Widget>[
          TextField(
            enableSuggestions: false,
            onChanged: (text) => filterCountryList(text),
            onSubmitted: (_) {},
          ),
          Container(
              height: mediaQuery.height * 0.7,
              width: mediaQuery.width * 0.7,
              child: ListView.builder(
                  itemCount: countryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Country country = countryList[index];
                    return FlatButton(
                      onPressed: () {
                        Navigator.pop(context, country);
                      },
                      child: Text(country.name),
                    );
                  })
              ),
        ],
      ),
    );
  }
 
  // TODO: add "best match" feature
  // TODO: add country code search feature
  
  void filterCountryList(String text) {
    final filteredCountries = countries.where((country) {
      return country.name.toLowerCase().startsWith(text.toLowerCase().trim());
    });
    setState(() {
      countryList = filteredCountries.toList();
    });
  }
}
