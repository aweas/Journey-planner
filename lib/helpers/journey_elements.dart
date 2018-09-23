import 'package:flutter/material.dart';

String buildString(int time) {
  int hours = (time / 60).floor();
  int minutes = time % 60;
  String res = "";
  if (hours != 0) res += "$hours hours ";
  if (minutes != 0) res += "$minutes minutes";
  return res;
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
            dense: true,
            key: key,
            leading: element.icon,
            title: new Text(element.name),
            subtitle: new Text(element.comment),
            trailing: new Text(buildString(element.time)));
}

class JourneyElementBasicForm {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController descController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final Function saveHandler;

  JourneyElementBasicForm({this.saveHandler});

  List<Widget> getContent() {
      List<Widget> result = [
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Tram', labelText: 'Name'),
            controller: nameController),
        new TextFormField(
            decoration:
                new InputDecoration(hintText: 'T27', labelText: 'Description'),
            controller: descController),
        new TextFormField(
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: false),
            decoration:
                new InputDecoration(hintText: '15', labelText: 'Time (minutes)'),
            controller: timeController),
        new ButtonTheme.bar(
            child: new ButtonBar(children: [
          RaisedButton(
            child: const Text(
              "OK",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              JourneyElement input = new JourneyElement(
                  icon: new Icon(Icons.directions_bus),
                  name: nameController.text,
                  comment: descController.text,
                  time: int.parse(timeController.text));

              this.saveHandler(input);
            },
            color: Colors.blue,
          )
        ]))
      ];

      return result;
    }

    Widget buildColumn() {
      Widget result;
        result = Container(
            child: new Column(children: this.getContent()), padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 241.0);

      return result;
    }

    Widget buildContainer() {
      return new ListView(children: this.getContent());
    }
}
