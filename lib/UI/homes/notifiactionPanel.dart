import 'package:VTOP_Extended/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPanel extends StatefulWidget {
  @override
  _NotificationsPanelState createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel> {
  final items = List<String>.generate(10, (i) => "Notifiation ${i + 1}");

  Widget slideLeftBackground() {
    return Container(
      padding: EdgeInsets.only(right: 40),
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      padding: EdgeInsets.only(left: 40),
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: backgroundColor,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
                color: Colors.white,
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      setState(() {
                        items.removeAt(index);
                      });
                    }
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("$item dismissed"),
                      duration: Duration(milliseconds: 500),
                    ));
                  },
                  background: slideRightBackground(),
                  secondaryBackground: slideLeftBackground(),
                  child: ListTile(
                    title: Text('${items[index]}'),
                    // subtitle: Text('Hello'),
                    leading: Icon(
                      Icons.warning_amber_outlined,
                    ),
                  ),
                ));
          },
        ));
  }
}
