import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Georgia',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kazakhstan',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Malta',
    'Moldova',
    'Monaco'
  ];

  @override
  Widget build(BuildContext context) {
    Widget firstColumn = Expanded(
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontSize: 16),
          ),
          Text('subtitle'),
        ],
      ),
    );

    Widget secondColumn = Expanded(
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontSize: 16),
          ),
          Text('subtitle'),
        ],
      ),
    );

    Widget thirdColumn = Expanded(
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontSize: 16),
          ),
          Text('subtitle'),
        ],
      ),
    );

    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: 60),
        Container(
            padding: const EdgeInsets.all(24),
            child: Text(
              "List of stocks traded in the market that can be bought, sold and analyzed",
              textAlign: TextAlign.center,
            )),
        Expanded(
            child: ListView.builder(
          itemCount: europeanCountries.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[firstColumn, secondColumn, thirdColumn],
                ),
              ),
            );
          },
        ))
      ],
    ));
  }
}
