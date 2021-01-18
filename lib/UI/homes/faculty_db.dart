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
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Container(
                            child: Text('VIT'),
                          ),
                        ),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].department),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacultyDetails(
                                faculty: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                      ));
                });
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
          backgroundColor: Color(0xFF2c2c2c),
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
                      child: faculty.photoLink == ''
                          ? Icon(
                              Icons.person,
                              size: 300,
                              color: Colors.grey[600],
                            )
                          : Image.network(
                              'https://drive.google.com/uc?export=view&id=' +
                                  faculty.photoLink.substring(
                                    faculty.photoLink.indexOf('/d/') + 3,
                                    faculty.photoLink.indexOf('/view'),
                                  ),
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
                        fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  faculty.department,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Email:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    faculty.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () async {
                    var url = 'mailto:' + faculty.email;
                    if (await canLaunch(url)) await launch(url);
                  },
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
