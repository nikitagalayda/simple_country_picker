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

    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      children: [
        Container(
          height: mediaQuery.height * 0.7,
          // color: Colors.red,
          // Using ListView instead of Column fixes the scroll issue,
          // TODO: find out why
          child: ListView(
            children: <Widget>[
              Container(
                height: mediaQuery.height * 0.1,
                padding: EdgeInsets.all(15),
                child: TextField(
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  onChanged: (text) => filterCountryList(text),
                ),
              ),
              Container(
                height: mediaQuery.height * 0.6,
                child: ListView.separated(
                    itemCount: countryList.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Country country = countryList[index];
                      return Container(
                        child: ListTile(
                          title: Text(country.name),
                          onTap: () {
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
