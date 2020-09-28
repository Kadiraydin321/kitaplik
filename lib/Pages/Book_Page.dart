import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/Book_Comments.dart';
import 'package:kitaplik/Services/book_functions.dart';
import 'package:kitaplik/Services/filter.dart';
import 'package:kitaplik/Services/global_veriable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookPage extends StatefulWidget {
  final String kitapAdi;
  const BookPage(this.kitapAdi);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Firestore.instance
            .collection("books")
            .document(widget.kitapAdi)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var kitap = snapshot.data.data;
            List kitapUsers = kitap["bookUsers"];
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: kitap["bookImage"],
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Scaffold(
                  backgroundColor: Color(0xFF627195).withOpacity(0.8),
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text("Kitap Detayı"),
                    centerTitle: true,
                    leading: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Icon(Icons.arrow_back)),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookComments(kitap["bookName"])))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Icon(FontAwesomeIcons.solidCommentDots)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            bosKitaplik = false;
                            kitapUsers.contains(userID)
                                ? setState(() {
                                    kitapligaKitapSil(kitap["bookName"]);
                                  })
                                : setState(() {
                                    kitapligaKitapEkle(
                                        kitap["bookName"],
                                        kitap["bookImage"],
                                        kitap["bookAuthor"][0],
                                        kitapYayinevi(kitap["bookAuthor"]),
                                        kitap["bookCategory"]);
                                  });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              kitapUsers.contains(userID)
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: CachedNetworkImage(
                              imageUrl: kitap["bookImage"],
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.9),
                                child: Text(
                                  widget.kitapAdi,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 10),
                            child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.9),
                                child: Text(
                                  kitap["bookAuthor"][0],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 10),
                            child:FutureBuilder(
                                  future: puanHesapla(widget.kitapAdi),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "Puan: " + snapshot.data,
                                        style: TextStyle(
                                  fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        kitapYayinevi(kitap["bookAuthor"]),
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Yayınevi",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 1.5,
                                  height: 38,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          categoryFilter(kitap["bookCategory"]),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Kategori",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color(colors[1]),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        child: Text(
                                          "Açıklama",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                            bottom: 5),
                                        child: Text(
                                          kitap["bookInfo"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
