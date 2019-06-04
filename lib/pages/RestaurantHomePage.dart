import 'package:flutter/material.dart';

class BasicAppBarSample extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() => _BasicAppBarSampleState();
}

class _BasicAppBarSampleState extends State<BasicAppBarSample> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome!'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            // action button
            RawMaterialButton(
              child: Text("MENU"),
              fillColor: Colors.green,
              splashColor: Colors.lightGreen,
              onPressed: () {
                _select(choices[0]);
              },
            ),
            // action button
            RawMaterialButton(
              child: Text("RESERVATION"),
              fillColor: Colors.green,
              splashColor: Colors.lightGreen,
              onPressed: () {
                // _select(choices[1]);
              },
            ),
            RawMaterialButton(
              child: Text("CANCELLATION"),
              fillColor: Colors.green,
              splashColor: Colors.redAccent,
              onPressed: () {
                // _select(choices[1]);
              },
            ),

            // overflow menu
            // PopupMenuButton<Choice>(
            //    child: Text("RESERVATION"),
            //   onSelected: _select,
            //   itemBuilder: (BuildContext context) {
            //     return choices.skip(2).map((Choice choice) {
            //       return PopupMenuItem<Choice>(
            //         value: choice,
            //         child: Text(choice.title),
            //       );
            //     }).toList();
            //   },
            //),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChoiceCard(choice: _selectedChoice),
        ),
      ),
    );
  }
}

// class Choice {
//   const Choice({this.title, this.icon});

//   final String title;
//   final IconData icon;
// }

class Choice {
  const Choice({this.imageUrl, this.name, this.description, this.price});

  final String imageUrl;
  final String name;
  final String description;
  final String price;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      imageUrl: "https://picsum.photos/250?image=9",
      name: "Pizza Hawai",
      description: "sos rosii, mozarella, sunca, ananas",
      price: "30 lei"),
  // const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  // const Choice(title: 'Boat', icon: Icons.directions_boat),
  // const Choice(title: 'Bus', icon: Icons.directions_bus),
  // const Choice(title: 'Train', icon: Icons.directions_railway),
  // const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('https://picsum.photos/250?image=9'),
              )
            ],
          )
          // Image.network('https://picsum.photos/250?image=9'),
        ],
      ),
    );
  }
}

void main() {
  runApp(BasicAppBarSample());
}
