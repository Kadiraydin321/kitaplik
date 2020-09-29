import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/All_Books.dart';
import 'package:kitaplik/Pages/Book_Page.dart';
import 'package:kitaplik/Pages/Library_Page.dart';
import 'package:kitaplik/Services/book_functions.dart';
import 'package:kitaplik/Services/filter.dart';
import 'package:kitaplik/widgets/drawer.dart';
import '../Services/global_veriable.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF202639), Color(0xFF3f4c77)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Ana Sayfa"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: drawerMenu(context),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kitaplığım",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tümü",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                  onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LibraryPage())).then((value) {
                                        setState(() {});
                                      }),
                                  child: Icon(
                                    FontAwesomeIcons.angleRight,
                                    size: 23,
                                    color: Colors.white,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: bosKitaplik == false ? 4 : 1, child: imageSlider()),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Önerilen Kitaplar",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Tüm Kitaplar",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                  onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllBooks())).then((value) {
                                        setState(() {});
                                      }),
                                  child: Icon(
                                    FontAwesomeIcons.angleRight,
                                    size: 23,
                                    color: Colors.white,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 4, child: recommendedBooks()),
                ],
              ),
            ),
          )),
    );
  }

// Önerilen kitaplar kısmı
  Widget recommendedBooks() {
    return FutureBuilder(
      future: Firestore.instance.collection("books").limit(20).getDocuments(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                var kitaplar = snapshot.data.documents[index];
                List kitapUsers = kitaplar["bookUsers"];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookPage(kitaplar["bookName"])))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: kitaplar["bookImage"],
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Text(
                                  kitaplar["bookName"].toString().length > 60
                                      ? kitaplar["bookName"]
                                              .toString()
                                              .substring(0, 60) +
                                          "..."
                                      : kitaplar["bookName"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: Text(
                                  kitaplar["bookAuthor"][0],
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: Text(
                                  categoryFilter(kitaplar["bookCategory"]),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: FutureBuilder(
                                  future: puanHesapla(kitaplar["bookName"]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "Puan: " + snapshot.data,
                                        style: TextStyle(color: Colors.grey),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                bosKitaplik = false;
                                kitapUsers.contains(userID)
                                    ? setState(() {
                                        kitapligaKitapSil(kitaplar["bookName"]);
                                      })
                                    : setState(() {
                                        kitapligaKitapEkle(
                                            kitaplar["bookName"],
                                            kitaplar["bookImage"],
                                            kitaplar["bookAuthor"][0],
                                            kitapYayinevi(
                                                kitaplar["bookAuthor"]),
                                            kitaplar["bookCategory"]);
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
                            ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

// Kitaplığım kısmı
  Widget imageSlider() {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.35,
        child: FutureBuilder(
            future: Firestore.instance
                .collection("users")
                .document(userID)
                .collection("library")
                .limit(10)
                .getDocuments(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List kitap = snapshot.data.documents;
                if (kitap.length != 0) {
                  bosKitaplik = false;
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListView(
                      children: listele(context, kitap),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                } else {
                  bosKitaplik = true;
                  return SizedBox(
                    child: Center(
                      child: Text(
                        "Kitaplığına kitap ekleme zamanı.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  listele(context, List kitap) {
    List<Widget> items = [];
    for (int i = 0; i < kitap.length; i++) {
      items.add(Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookPage(kitap[i]["bookName"])))
                .then((value) {
              setState(() {});
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: kitap[i]["bookImage"],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ));
    }
    return items;
  }
}
