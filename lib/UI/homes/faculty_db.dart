import 'package:VTOP_Extended/main.dart';
import 'package:VTOP_Extended/models/faculty.dart';
import 'package:VTOP_Extended/services/database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FacultyDB extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Faculty>>(
        future: _databaseService.getFaculty(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              thickness: 2.0,
                          child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FacultyCard(
                      faculty: snapshot.data[index],
                    );
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }
}

class FacultyDetails extends StatelessWidget {
  final Faculty faculty;
  FacultyDetails({this.faculty});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(faculty.name),
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 300,
                      child: (faculty.photoLink == '')
                          ? Icon(
                              Icons.person,
                              size: 300,
                              color: Colors.grey[600],
                            )
                          : Image.network(
                              faculty.photoLink,
                              fit: BoxFit.contain,
                              height: 300,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            )),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Department:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Text(
                        faculty.department,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Email:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: InkWell(
                        child: Text(
                          faculty.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () async {
                          var url = 'mailto:' + faculty.email;
                          if (await canLaunch(url)) await launch(url);
                        },
                      ),
                    )
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}

class FacultySearch extends SearchDelegate<Faculty> {
  DatabaseService _databaseService = DatabaseService();
  Future<List<Faculty>> facultyList;
  FacultySearch() {
    facultyList = _databaseService.getFaculty();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Faculty>>(
      future: facultyList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data
              .where((x) => x.name.toLowerCase().contains(query.toLowerCase()));
          return ListView(
              children: results
                  .map<Widget>((faculty) => FacultyCard(faculty: faculty))
                  .toList());
        } else {
          return Center(child: Text('Hi'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Faculty>>(
      future: facultyList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (query != '') {
            final results = snapshot.data
                .where((x) => x.name.toLowerCase().contains(query.toLowerCase()));
            return ListView(
                children: results
                    .map<Widget>((faculty) => FacultyCard(faculty: faculty))
                    .toList());
          }
          return Center(child: Text('Type.', style: TextStyle(color: Colors.white),));
        } else {
          return Container();
        }
      },
    );
  }
}

class FacultyCard extends StatelessWidget {
  final Faculty faculty;
  FacultyCard({this.faculty});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        child: ListTile(
          leading: Image.network(
              faculty.photoLink),
          title: Text(faculty.name),
          subtitle: Text(faculty.department),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FacultyDetails(
                  faculty: faculty,
                ),
              ),
            );
          },
        ));
  }
}

