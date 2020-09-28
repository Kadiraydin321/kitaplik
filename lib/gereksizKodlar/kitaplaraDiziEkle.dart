import 'package:cloud_firestore/cloud_firestore.dart';

Future veriGuncelle() async {
  var cek = await Firestore.instance.collection("books").getDocuments();
  int i = 0;
  cek.documents.forEach((value) {
    Firestore.instance
        .collection("books")
        .document(value.data["bookName"])
        .updateData({"bookUsers": []});
    print(i.toString()+"-\t"+value.data["bookName"]);
    i++;
  });
}
