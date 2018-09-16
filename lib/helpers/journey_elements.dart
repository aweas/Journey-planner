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
            key: key,
            leading: element.icon,
            title: new Text(element.name),
            subtitle: new Text(element.comment),
            trailing: new Text(buildString(element.time)));
}

class JourneyElementInput extends StatefulWidget {
  final Function saveHandler;

  JourneyElementInput({Key key, this.saveHandler}) : super(key: key);

  @override
  _JourneyElementInput createState() => _JourneyElementInput(saveHandler);
}

class _JourneyElementInput extends State<JourneyElementInput> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final Function saveHandler;

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController descController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();

  _JourneyElementInput(this.saveHandler) : super();

  @override
  Widget build(BuildContext context) {
    Column result = new Column(children: <Widget>[
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
              time: int.parse(timeController.text)
              );

            this.saveHandler(input);
          },
          color: Colors.blue,
        )
      ]))
    ]);

    return result;
  }
}
