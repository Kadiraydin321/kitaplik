import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/Other_Users_Library_Page.dart';
import 'package:kitaplik/Services/global_veriable.dart';
import 'package:kitaplik/widgets/drawer.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF202639), Color(0xFF3f4c77)])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: drawerMenu(context),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Kullanıcılar"),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: Firestore.instance.collection("users").getDocuments(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = snapshot.data.documents[index];
                      if (user["user_id"] != my_user.uid) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherLibraryPage(user.documentID)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF68b0ab),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(7.0, 7.0),
                                      blurRadius: 10)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipOval(
                                        child: Image.network(
                                            user == null
                                                ? "https://developers.google.com/web/images/contributors/no-photo.jpg"
                                                : user["user_photo"],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover)),
                                    Text(
                                      user == null ? "" : user["user_name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.angleRight,
                                      color: Colors.white,
                                      size: 23,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ));
  }
}
