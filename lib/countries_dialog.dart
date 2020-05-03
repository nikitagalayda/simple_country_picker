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

  //TODO: fix the scrollable textfield bug
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Container(
      child: SimpleDialog(
        // contentPadding: EdgeInsets.all(0),
        // titlePadding: EdgeInsets.all(50),
        children: [
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (text) => filterCountryList(text),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                // TODO: change height dynamically depending on how many items are shown
                // problem: when only a few items are showing, a lot of white space left in dialog
                height: mediaQuery.height * 0.7,
                width: mediaQuery.width * 0.7,
                child: Container(
                  // margin: EdgeInsets.only(bottom: 30),
                  child: ListView.separated(
                      itemCount: countryList.length,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        Country country = countryList[index];
                        return Container(
                          // padding: EdgeInsets.only(bottom: 10),
                          // margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text(country.name),
                            onTap: () {
                              Navigator.pop(context, country);
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: add country code search feature

  void filterCountryList(String text) {
    final filteredCountries = countries.where((country) {
      return country.name.toLowerCase().startsWith(text.toLowerCase().trim());
    });
    // Avoid erasing the whole list if the user misstypes a word
    // ex: if the user types Germanyy the list would not be empty
    // since Germany was matched upon the user typing Germany
    if (filteredCountries.isNotEmpty) {
      setState(() {
        countryList = filteredCountries.toList();
      });
    }
  }
}
