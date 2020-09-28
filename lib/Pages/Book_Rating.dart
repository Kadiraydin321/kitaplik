import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Services/global_veriable.dart';

class BookRating extends StatefulWidget {
  final String kitapAdi;
  const BookRating(this.kitapAdi);
  @override
  _BookRatingState createState() => _BookRatingState();
}

class _BookRatingState extends State<BookRating> {
  TextEditingController _yorum = TextEditingController();
  var puan = 5.0;
  var yorum;

  @override
  void initState() {
    () async {
      try {
        var kontrol = await Firestore.instance
            .collection("books")
            .document(widget.kitapAdi)
            .collection("rating")
            .document(my_user.uid)
            .get();
        puan = kontrol.data["bookRating"];
        _yorum.text = kontrol.data["bookComment"];
        setState(() {});
      } catch (e) {
        print("Hata: " + e.toString());
      }
    }();
    super.initState();
  }

  Future kitapPuanla() async {
    // ignore: unused_local_variable
    var ekle = await Firestore.instance
        .collection("books")
        .document(widget.kitapAdi)
        .collection("rating")
        .document(my_user.uid)
        .setData({"bookRating": puan, "bookComment": yorum});
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
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text("Kitabı Puanla"),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    yorum = _yorum.text;
                    kitapPuanla();
                   Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      FontAwesomeIcons.check,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Puan: ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        RatingBar(
                          initialRating: puan,
                          itemCount: 5,
                          itemSize: 20,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.all(2),
                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.orange,
                                );
                              case 2:
                                return Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.limeAccent,
                                );
                              case 3:
                                return Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.limeAccent[700],
                                );
                              case 4:
                                return Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.lightGreenAccent[700],
                                );
                            }
                          },
                          onRatingUpdate: (yenipuan) {
                            puan = yenipuan;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _yorum,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                      maxLength: 500,
                      maxLines: 15,
                      minLines: 1,
                      decoration: InputDecoration(
                          labelText: "Yorum",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          hintText: "Yorumunuzu giriniz.",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          counterStyle: TextStyle(color: Colors.grey),
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
