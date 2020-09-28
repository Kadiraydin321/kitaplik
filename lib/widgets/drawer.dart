import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplik/Pages/All_Books.dart';
import 'package:kitaplik/Pages/Dashboard_Page.dart';
import 'package:kitaplik/Pages/Library_Page.dart';
import 'package:kitaplik/Pages/Login_Page.dart';
import 'package:kitaplik/Pages/Users_Page.dart';
import 'package:kitaplik/Services/global_veriable.dart';

Drawer drawerMenu(BuildContext context) {
  return Drawer(
    elevation: 0,
    child: Container(
     decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF202639),Color(0xFF3f4c77)])
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                ClipOval(
                    child: Image.network(my_user.photoUrl,
                        width: 100, height: 100, fit: BoxFit.cover)),
                Text(my_user.displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Ana Sayfa",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
            },
          ),
           ListTile(
            title: Text(
              "Tüm Kitaplar",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.bookOpen,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllBooks()));
            },
          ),
          ListTile(
            title: Text(
              "Kitaplığım",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.bookReader,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LibraryPage()));
            },
          ),
           ListTile(
            title: Text(
              "Kullanıcılar",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.users,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UsersPage()));
            },
          ),
          ListTile(
            title: Text(
              "Çıkış yap",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
            onTap: () {
              my_googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
    ),
  );
}
