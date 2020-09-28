import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitaplik/Services/global_veriable.dart';

Future kitapligaKitapEkle(
    bookName, bookImage, bookAuthor, bookPublisher, bookCategory) async {
  // ignore: unused_local_variable
  var kitapEkle = await Firestore.instance
      .collection("users")
      .document(userID)
      .collection("library")
      .document(bookName)
      .setData({
    "bookName": bookName,
    "bookImage": bookImage,
    "bookAuthor": bookAuthor,
    "bookPublisher": bookPublisher,
    "bookCategory": bookCategory
  });
  // ignore: unused_local_variable
  var userEkle = await Firestore.instance
      .collection("books")
      .document(bookName)
      .updateData({
    "bookUsers": FieldValue.arrayUnion([userID])
  });
}

Future kitapligaKitapSil(bookName) async {
  // ignore: unused_local_variable
  var kitapSil = await Firestore.instance
      .collection("users")
      .document(userID)
      .collection("library")
      .document(bookName)
      .delete();
  // ignore: unused_local_variable
  var userSil = await Firestore.instance
      .collection("books")
      .document(bookName)
      .updateData({
    "bookUsers": FieldValue.arrayRemove([userID])
  });
}
