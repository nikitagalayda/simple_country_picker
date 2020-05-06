import 'package:flutter/material.dart';

import './country.dart';
import './county_codes.dart';

class CountriesDialog extends StatefulWidget {
  @override
  _CountriesDialogState createState() => _CountriesDialogState();
}

class _CountriesDialogState extends State<CountriesDialog> {
  List<Country> countryList;
  double dialogSize;
  int textFieldHeight = 100;

  @override
  void initState() {
    super.initState();
    countryList = countries;
    dialogSize = 0.7;
  }

  //TODO: fix the scrollable textfield bug

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Container(
      height: mediaQuery.height * dialogSize,
      // height: 200,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        children: [
          Container(
            // height: 200,
            height: mediaQuery.height * dialogSize,
            // color: Colors.red,
            // Using ListView instead of Column fixes the scroll issue,
            // TODO: find out why
            child: ListView(
              children: <Widget>[
                Container(
                  height: 100,
                  // height: mediaQuery.height * (dialogSize * 1/5),
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    onChanged: (text) => filterCountryList(text),
                    onTap: () => changeDialogSize(0.4),
                  ),
                ),
                Container(
                  // color: Colors.green,
                  // height: 150,
                  height: mediaQuery.height * dialogSize - textFieldHeight,
                  child: ListView.separated(
                      itemCount: countryList.length,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        Country country = countryList[index];
                        return Container(
                          child: SimpleDialogOption(
                            child: Text(country.name),
                            onPressed: () {
                              Navigator.pop(context, country);
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TODO: add country code search feature

  void changeDialogSize(double newSize) {
    setState(() {
      dialogSize = newSize;
    });
  }

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
        countryList.forEach((f) {
          print(f.name);
        });
      });
    }
  }
}
