import 'package:flutter/material.dart';
import 'package:journey_list/helpers/journey_plans.dart';
import 'package:journey_list/helpers/journey_elements.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(
        title: 'Journey planner',
        planMembers: <Widget>[],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.planMembers}) : super(key: key);
  final String title;
  final List<Widget> planMembers;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(children: [new Column(children: widget.planMembers)]),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          JourneyElement element = new JourneyElement(
              icon: const Icon(Icons.directions_bus),
              name: "Bus do kato",
              comment: "Inter",
              time: 75);
          JourneyPlan plan = new JourneyPlan(elements: [element]);
          setState(() {
            widget.planMembers.add(plan.buildCard());
          });
          AlertDialog form = new AlertDialog(
            title: new Text("test"),
            content: new ListView(children: [new JourneyElementInput()]),
          );
          //FIXME:
          showDialog(context: context, builder: (BuildContext b) => form);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
