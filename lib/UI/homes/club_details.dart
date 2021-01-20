import 'package:VTOP_Extended/models/clubs.dart';
import 'package:flutter/material.dart';

// TODO: MAKE THIS PRETTY
class ClubDetails extends StatelessWidget {
  final Club club;
  ClubDetails({this.club});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club.name),
        backgroundColor: Color(0xFF2c2c2c),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 250,
                child: club.logo == ''
                    ? Center(
                        child: Text(
                          'No logo provided :(',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Image.network(
                        'https://drive.google.com/uc?export=view&id=' +
                            club.logo.substring(
                              club.logo.indexOf('/d/') + 3,
                              club.logo.indexOf('/view'),
                            ),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ), Text("About: ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            )),
            SizedBox(
              height: 10
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                color: Colors.grey[700],
              ),
              height: 80,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                club.bio,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic),
              ),
            )
            ),
            SizedBox(
              height: 30,
            ),
            Text("President: ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            )),
            SizedBox(
              height: 10
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
                  club.president, 
                  style: TextStyle(
                      color: Colors.white,),
              ),
            )
            ),
            SizedBox(
              height: 20,
            ),
             Text("Faculty: ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            )),
            SizedBox(
              height: 10
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
                 club.faculty, 
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                      ),
              ),
            )
            ),
           
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
