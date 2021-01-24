import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventView extends StatefulWidget {
  final String url;
  final String name;
  final String details;
  final String contact;
  final String club;
  final String president;

  EventView(
      {this.url,
      this.name,
      this.details,
      this.contact,
      this.club,
      this.president});

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              ispressed = !ispressed;
            });
          },
          backgroundColor: Colors.red[900],
          child: Icon(ispressed == false
              ? Icons.thumb_up_alt_outlined
              : Icons.thumb_up)),
      backgroundColor: Colors.black,
      body: Scrollbar(
        thickness: 1.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.url))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.url))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Event name: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Text(
                        widget.name == null
                            ? "name not available :("
                            : widget.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Event Details: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    widget.details == null
                        ? "details not updated yet :("
                        : widget.details,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Organising Club: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Text(
                        widget.club == null
                            ? "Club name not known :("
                            : widget.club,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Club President: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Text(
                        widget.president == null
                            ? " no president details found  :("
                            : widget.president,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text("Contact Details: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    widget.contact == null
                        ? "Contact details not updated yet :("
                        : widget.contact,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
