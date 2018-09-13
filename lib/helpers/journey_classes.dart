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

  void add(JourneyElement element) {
    this.journeyElements.add(element);
    this.duration += element.time;
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

class JourneyElementInput extends Form {
  final JourneyElement element;
  final _JourneyPlanCard plan;
  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  JourneyElementInput({this.element, this.plan})
      : super(
            key:formKey,
            child: new Column(children: <Widget>[
              new TextFormField(
                  decoration:
                      new InputDecoration(hintText: 'Tram', labelText: 'Name'),
                  onSaved: (String value){
                    element.name = value;
                  }),
              new TextFormField(
                  decoration: new InputDecoration(
                      hintText: 'T27', labelText: 'Description'),
                  onSaved: (String value){
                    element.comment = value;
                  }),
              new TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: false),
                  decoration: new InputDecoration(
                      hintText: '15', labelText: 'Time (minutes)'),
                  onSaved: (String value){
                    element.time = int.parse(value);
                  }),
              new ButtonTheme.bar(
                  child: new ButtonBar(children: [
                RaisedButton(
                  child: const Text(
                    "OK",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                      formKey.currentState.save();
                      plan.setState((){
                        element.icon = new Icon(Icons.directions_bus);
                        plan.tile = null;
                        plan.widget.plan.add(element);
                      });
                  },
                  color: Colors.blue,
                )
              ]))
            ]));
}

class JourneyPlanCard extends StatefulWidget {
  final JourneyPlan plan;
  JourneyPlanCard({Key key, this.plan}) : super(key: key);

  @override
  _JourneyPlanCard createState() => _JourneyPlanCard();
}

class _JourneyPlanCard extends State<JourneyPlanCard> {
  JourneyElementInput tile;
  JourneyElement newTile = new JourneyElement();

  @override
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

    if (tile != null) {
      newData.add(tile);
      newData.add(new Divider());
    }

    newData.add(new ButtonTheme.bar(
      child: new ButtonBar(
        children: <Widget>[
          new Text(buildString()),
          new FlatButton(
            child: const Text('Add new'),
            onPressed: () {
              setState(() {
                tile = new JourneyElementInput(element: newTile, plan:this);
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

  String buildString(){
     int hours = (widget.plan.duration/60).round();
     int minutes = widget.plan.duration%60;
     return "$hours hours, $minutes minutes";
  }
}
