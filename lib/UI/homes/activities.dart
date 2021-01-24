import 'dart:ui';
import 'package:VTOP_Extended/UI/homes/EventView.dart';
import 'package:VTOP_Extended/UI/homes/club_details.dart';
import 'package:VTOP_Extended/models/clubs.dart';
import 'package:VTOP_Extended/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  Activities({Key key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  AsyncSnapshot<QuerySnapshot> snapshot;
  @override
  Widget build(BuildContext context) {
    // final backgroundColor = Color(0xFF2c2c2c);
    // final firstTabColor = Color(0xFF1d1d1d);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Colors.purpleAccent,
            labelColor: Colors.purpleAccent.shade100,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Container(
                    child: Text(
                  "EVENTS",
                  style: TextStyle(letterSpacing: 1.5, fontSize: 16),
                )),
              ),
              Tab(
                child: Container(
                    child: Text(
                  "CLUBS",
                  style: TextStyle(letterSpacing: 1.5, fontSize: 16),
                )),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
        ));
  }
}

class FirstScreen extends StatelessWidget {
  final firstTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: firstTabColor,
        body: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('events').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return Scrollbar(
                  thickness: 2.0,
                  child: GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 0.65,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      padding: EdgeInsets.fromLTRB(15, 18, 15, 5),
                      children: snapshot.data.documents.map((doc) {
                        return GridTile(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventView(
                                          url: doc.data['url'],
                                          name: doc.data['name'],
                                          details: doc.data['details'],
                                          club: doc.data['club'],
                                          contact: doc.data['contact'],
                                          president: doc.data['president'],
                                        )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: buildItem(doc),
                              )
                            ],
                          ),
                        ));
                      }).toList()),
                );
              },
            )));
  }
}

class SecondScreen extends StatelessWidget {
  final secondTabColor = Color(0xFF1d1d1d);

  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Club>>(
          future: _databaseService.getClubs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      color: Colors.white, //Color(0xFF2c2c2c),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Container(
                            child: Text(
                                snapshot.data[index].clubType == 'Technical'
                                    ? 'T'
                                    : 'NT'),
                          ),
                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(color: Colors.black), //Colors.white)
                        ),
                        subtitle: Text(snapshot.data[index].clubType),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClubDetails(
                                club: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

Card buildItem(DocumentSnapshot doc) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: Colors.white,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: Colors.grey.shade700,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.50), BlendMode.darken),
                image: NetworkImage("${doc.data['url']}"))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${doc.data['name']}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
