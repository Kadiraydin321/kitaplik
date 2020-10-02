import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/Book_Rating.dart';
import 'package:kitaplik/Services/global_veriable.dart';

class BookComments extends StatefulWidget {
  final String kitapAdi;
  const BookComments(this.kitapAdi);
  @override
  _BookCommentsState createState() => _BookCommentsState();
}

class _BookCommentsState extends State<BookComments> {
  showAlertDialog(BuildContext context) {
    Widget silButonu = FlatButton(
      child: Text("Yorumu Sil"),
      onPressed: () {
        Firestore.instance
            .collection("books")
            .document(widget.kitapAdi)
            .collection("rating")
            .document(my_user.uid)
            .delete();
        setState(() {});
        Navigator.pop(context);
      },
    );
    Widget silmeButonu = FlatButton(
      child: Text("Yorumu Silme"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text("Yorumu silmek istediğinizden emin misiniz?"),
      actions: [silButonu, silmeButonu],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Kitap Yorumları"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookRating(widget.kitapAdi))).then((value) {
                        setState(() {});
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.plusCircle,
                      size: 22,
                    ),
                  ),
                )
              ],
            ),
            body: FutureBuilder(
              future: Firestore.instance
                  .collection("books")
                  .document(widget.kitapAdi)
                  .collection("rating")
                  .getDocuments(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.documents.length != 0) {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          var yorumlar = snapshot.data.documents[index];
                          return FutureBuilder(
                            future: Firestore.instance
                                .collection("users")
                                .document(yorumlar.documentID)
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var user = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(0xFF68b0ab),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(7.0, 7.0),
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        yorumlar.documentID == my_user.uid
                                            ? showAlertDialog(context)
                                            : () {}();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                                child: Image.network(
                                                    user["user_photo"],
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.cover)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          user["user_name"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Text(
                                                            "Puan: " +
                                                                yorumlar[
                                                                        "bookRating"]
                                                                    .toString()[0],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        yorumlar["bookComment"],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        });
                  } else {
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                          child: Text(
                        "Bu kitaba yorum yapılmamış. İlk yorumu siz yapın.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                    );
                  }
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
