import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
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
            // child: StreamBuilder<QuerySnapshot>(
            //   stream: Firestore.instance.collection('events').snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (!snapshot.hasData)
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     return StaggeredGridView.count(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 10.0,
            //       crossAxisSpacing: 10.0,
            //       padding: EdgeInsets.fromLTRB(15, 18, 15, 5),
            //       children: snapshot.data.documents
            //           .map((doc) => buildItem(doc))
            //           .toList(),
            //       staggeredTiles:
            //           generateRandomTiles(snapshot.data.documents.length),
            //     );
            //   },
            // )
            ));
  }
}
class SecondScreen extends StatelessWidget {
  final seconfTabColor = Color(0xFF1d1d1d);
  final List Clubs = [
    "Android Club",
    "Open Source Community",
    "Developer Student's Club",
    "Null Chapter"
  ];
  final List clubtype = ["Technical", "Technical", "Technical", "Technical"];
  @override
  // Firestore firestore;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: ListView.builder(
        //     itemCount: Clubs.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Card(
        //         elevation: 5,
        //         color: Colors.white, //Color(0xFF2c2c2c),
        //         child: ListTile(
        //           leading: CircleAvatar(
        //             child: Container(
        //               child: Text("VIT"),
        //             ),
        //           ),
        //           title: Text(
        //             Clubs[index],
        //             style: TextStyle(color: Colors.black //Colors.white
        //                 ),
        //           ),
        //           subtitle: Text(clubtype[index]),
        //           onTap: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) => ClubDetails()));
        //           },
        //           //onTap: () =>
        //           //debugPrint("Club Name: ${Clubs.elementAt(index)}"),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}