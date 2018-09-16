import 'package:flutter/material.dart';
import 'package:journey_list/helpers/journey_elements.dart';

class JourneyPlan {
  List<JourneyElement> journeyElements;
  int duration = 0;
  JourneyPlan({List<JourneyElement> elements}) {
    this.journeyElements = elements;
  }

  JourneyPlanCard buildCard() {
    duration = 0;
    this.journeyElements.forEach((x) => duration += x.time);
    return new JourneyPlanCard(plan: this);
  }

  void add(JourneyElement element) {
    this.journeyElements.add(element);
    this.duration += element.time;
  }
}

class JourneyPlanCard extends StatefulWidget {
  final JourneyPlan plan;
  JourneyPlanCard({Key key, this.plan}) : super(key: key);

  @override
  _JourneyPlanCard createState() => _JourneyPlanCard();
}

class _JourneyPlanCard extends State<JourneyPlanCard> {
  JourneyElementInput inputFormTile;
  JourneyElement newTile = new JourneyElement();

  void addItemToList(JourneyElement tile) {
    setState(() {
      inputFormTile = null;
      widget.plan.add(tile);
    });
  }

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

    if (inputFormTile != null) {
      newData.add(inputFormTile);
      newData.add(new Divider());
    }

    newData.add(new ButtonTheme.bar(
      child: new ButtonBar(
        children: <Widget>[
          new Text( craftHourString()
            ),
          new FlatButton(
            child: const Text('Add new'),
            onPressed: () {
              setState(() {
                inputFormTile = new JourneyElementInput(saveHandler: addItemToList);
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

  String _leadingZero(int time) {
    if(time>=10)
      return time.toString();
    else if(time!=0)
      return "0$time";
    else
      return "00";
  }

  String craftHourString() {
    int hourNow = DateTime.now().hour;
    int minuteNow = DateTime.now().minute;
    int minutesTillNow = hourNow*60+minuteNow;

    int minutesTillDestination = minutesTillNow + widget.plan.duration;
    int hourThen = (minutesTillDestination/60).floor();
    int minuteThen = minutesTillDestination%60;

    
    String hourNowZero = _leadingZero(hourNow);
    String minuteNowZero = _leadingZero(minuteNow);
    String hourThenZero = _leadingZero(hourThen);
    String minuteThenZero = _leadingZero(minuteThen);
    String elapsed = buildString(widget.plan.duration);

    String res = "$hourNowZero:$minuteNowZero - $hourThenZero:$minuteThenZero ($elapsed)";

    return res;
  }
}