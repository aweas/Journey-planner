import 'package:flutter/material.dart';

class JourneyPlan {
  List<JourneyElement> journeyElements;
  int duration = 0;
  JourneyPlan({List<JourneyElement> elements}) {
    this.journeyElements = elements;
  }

  JourneyPlanCard buildCard() {
    this.journeyElements.forEach((x) => duration += x.time);
    return new JourneyPlanCard(plan: this);
  }
}

class JourneyElement {
  Icon icon;
  String name;
  String comment;
  int time;

  JourneyElement({Icon icon, String name, String comment, int time}) {
    this.icon = icon;
    this.name = name;
    this.comment = comment;
    this.time = time;
  }

  JourneyElementTile buildTile() {
    return new JourneyElementTile(element: this);
  }
}

class JourneyElementTile extends ListTile {
  JourneyElementTile({Key key, JourneyElement element})
      : super(
            key: key,
            leading: element.icon,
            title: new Text(element.name),
            subtitle: new Text(element.comment),
            trailing: new Text(element.time.toString()));
}

class JourneyPlanCard extends StatefulWidget {
  final JourneyPlan plan;
  JourneyPlanCard({Key key, this.plan}) : super(key: key);

  @override
  _JourneyPlanCard createState() => _JourneyPlanCard();
}

class _JourneyPlanCard extends State<JourneyPlanCard> {
  Widget build(BuildContext context) {
    List<JourneyElementTile> tiles = [];
    widget.plan.journeyElements
        .forEach((element) => tiles.add(element.buildTile()));

    List<Widget> temp = new List.from(tiles);
    List<Widget> newData = [];
    temp.forEach((item) {
      newData.add(item);
      newData.add(new Divider());
    });

    newData.add(new ButtonTheme.bar(
      child: new ButtonBar(
        children: <Widget>[
          new FlatButton(
            child: const Text('Add new'),
            onPressed: () {
              setState(() {
                widget.plan.journeyElements.add(
                    new JourneyElement(icon: const Icon(Icons.directions_car),
                    name: "test",
                    comment: "test2",
                    time: 4));
              });
            },
          ),
        ],
      ),
    ));

    Card card = new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: newData,
          ),
        );

    return card;
  }
}
