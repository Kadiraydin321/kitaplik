import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Kullanıcı verileri
// ignore: non_constant_identifier_names
GoogleSignIn my_googleSignIn;
// ignore: non_constant_identifier_names
FirebaseUser my_user;
var userID = my_user.uid;

class User {
  final String uid;
  User({this.uid});
}

// Gereken veriler
List colors = [
  0xFF2d4059,
  0xFF1e272e,
  0xFF1D212B,
  0xFF393b44,
  0xFF393e46,
  0xFF41444b,
  0xFF52575d,
  0xFF797a7e,
  0xFF204051,
];

List categoryName = [
  "Edebiyat",
  "Cocuk-ve-Genclik",
  "Prestij-Kitaplari",
  "Egitim-Basvuru",
  "Mitoloji-Efsane",
  "Arastirma-Tarih",
  "Din-Tasavvuf",
  "Sanat-Tasarim",
  "Felsefe",
  "Cizgi-Roman",
  "Hobi",
  "Bilim",
  "Mizah"
];
// ignore: non_constant_identifier_names
bool selectedListOrGrid_MyLibraryPage = false;
// ignore: non_constant_identifier_names
bool selectedListOrGrid_AllBooksPage = false;
bool bosKitaplik = false;