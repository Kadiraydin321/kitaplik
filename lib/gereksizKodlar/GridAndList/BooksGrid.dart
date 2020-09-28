import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitaplik/Pages/Book_Page.dart';
import 'package:kitaplik/Services/filter.dart';
import 'package:kitaplik/Services/global_veriable.dart';

class GridBooks extends StatefulWidget {
  @override
  _GridBooksState createState() => _GridBooksState();
}

class _GridBooksState extends State<GridBooks> {
  @override
  Widget build(BuildContext context) {
    var category = 1;
    return Container(
      child: FutureBuilder(
        future: category == 1
            ? Firestore.instance
                .collection("users")
                .document(userID)
                .collection("library")
                .getDocuments()
            : Firestore.instance
                .collection("users")
                .document(userID)
                .collection("library")
                .where("bookCategory", isEqualTo: categoryName[category - 2])
                .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  var kitaplar = snapshot.data.documents[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookPage(kitaplar["bookName"])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
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
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              kitaplar["bookAuthor"].toString().length > 23
                                  ? kitaplar["bookAuthor"]
                                          .toString()
                                          .substring(0, 23) +
                                      "..."
                                  : kitaplar["bookAuthor"],
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              kitaplar["bookPublisher"].toString().length > 23
                                  ? kitaplar["bookPublisher"]
                                          .toString()
                                          .substring(0, 23) +
                                      "..."
                                  : kitaplar["bookPublisher"],
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              categoryFilter(kitaplar["bookCategory"]),
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
