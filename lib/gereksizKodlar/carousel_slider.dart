import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitaplik/Pages/Book_Page.dart';
import 'package:kitaplik/Services/global_veriable.dart';

class CompilcatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        width: size.width,
        child: FutureBuilder(
            future: Firestore.instance
                .collection("users")
                .document(userID)
                .collection("library")
                .limit(5)
                .getDocuments(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List kitap = snapshot.data.documents;
                return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(seconds: 5),
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: listele(context, kitap)));
              } else {
                return SizedBox();
              }
            }));
  }

  listele(context, List kitap) {
    List<Widget> items = [];
    for (int i = 0; i < kitap.length; i++) {
      items.add(Container(
        decoration: BoxDecoration(
            color: Color(colors[0]), borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookPage(kitap[i]["bookName"])));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    kitap[i]["bookImage"],
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.027,
                    ),
                    Text(
                      kitap[i]["bookName"],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      kitap[i]["bookAuthor"],
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      kitap[i]["bookInfo"].toString().substring(0, 100) + "...",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return items;
  }
}
