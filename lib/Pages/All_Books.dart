import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/Book_Page.dart';
import 'package:kitaplik/Services/book_functions.dart';
import 'package:kitaplik/Services/filter.dart';
import 'package:kitaplik/Services/global_veriable.dart';
import 'package:kitaplik/widgets/drawer.dart';

class AllBooks extends StatefulWidget {
  @override
  _AllBooksState createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  var _category = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF202639), Color(0xFF3f4c77)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Tüm Kitaplar"),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          selectedListOrGrid_AllBooksPage = false;
                          setState(() {});
                        },
                        child: Icon(
                          FontAwesomeIcons.list,
                          size: 23,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () {
                          selectedListOrGrid_AllBooksPage = true;
                          setState(() {});
                        },
                        child: Icon(
                          FontAwesomeIcons.gripVertical,
                          size: 23,
                          color: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
          drawer: drawerMenu(context),
          body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return;
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: DropdownButton(
                          dropdownColor: Color(0xFF202639),
                          value: _category,
                          icon: Icon(
                            FontAwesomeIcons.angleDown,
                            color: Colors.white,
                            size: 20,
                          ),
                          underline: SizedBox(),
                          onChanged: (value) => setState(() {
                            _category = value;
                          }),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                "Kategoriye göre sırala.",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[0]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[1]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[2]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[3]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 5,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[4]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 6,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[5]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 7,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[6]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 8,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[7]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 9,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[8]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 10,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[9]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 11,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[10]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 12,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[11]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 13,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                categoryFilter(categoryName[12]),
                                style: TextStyle(color: Colors.white),
                              ),
                              value: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: selectedListOrGrid_AllBooksPage == false
                          ? bookList()
                          : bookGrid(),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget bookList() {
    return Container(
      child: FutureBuilder(
        future: _category == 1
            ? Firestore.instance.collection("books").getDocuments()
            : Firestore.instance
                .collection("books")
                .where("bookCategory", isEqualTo: categoryName[_category - 2])
                .getDocuments(),
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
                            flex: 2,
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
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
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
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  onTap: () {
                                    bosKitaplik = false;
                                    kitapUsers.contains(userID)
                                        ? setState(() {
                                            kitapligaKitapSil(
                                                kitaplar["bookName"]);
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
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          )
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
      ),
    );
  }

  Widget bookGrid() {
    return Container(
      child: FutureBuilder(
        future: _category == 1
            ? Firestore.instance.collection("books").getDocuments()
            : Firestore.instance
                .collection("books")
                .where("bookCategory", isEqualTo: categoryName[_category - 2])
                .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  var kitaplar = snapshot.data.documents[index];
                  List kitapUsers = kitaplar["bookUsers"];
                  return InkWell(
                    onTap: () {
                      print(kitaplar["bookName"]);
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookPage(kitaplar["bookName"])))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: kitaplar["bookImage"],
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      bosKitaplik = false;
                                      kitapUsers.contains(userID)
                                          ? setState(() {
                                              kitapligaKitapSil(
                                                  kitaplar["bookName"]);
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
                                    child: Icon(
                                      kitapUsers.contains(userID)
                                          ? FontAwesomeIcons.solidBookmark
                                          : FontAwesomeIcons.bookmark,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              kitaplar["bookName"].toString().length > 23
                                  ? kitaplar["bookName"]
                                          .toString()
                                          .substring(0, 23) +
                                      "..."
                                  : kitaplar["bookName"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            kitaplar["bookAuthor"][0].toString().length > 23
                                ? kitaplar["bookAuthor"][0]
                                        .toString()
                                        .substring(0, 23) +
                                    "..."
                                : kitaplar["bookAuthor"][0] +
                                    "\n" +
                                    categoryFilter(kitaplar["bookCategory"]),
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          FutureBuilder(
                            future: puanHesapla(kitaplar["bookName"]),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
      ),
    );
  }
}
