
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key,
    required this.email,
    required this.userName
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold,),
        ),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.symmetric(vertical: 50),
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
              ),
              SizedBox(height: 15,),
              Text(
                widget.userName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30,),
              Divider(height: 2,),
              ListTile(
                onTap: () {
                  nextScreen(context, HomePage());
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.group),
                title: Text("Groups",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {},
                selected: true,
                selectedColor: Theme.of(context).primaryColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.group),
                title: Text("Profile",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Logout", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),),
                          content: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout",
                  style: TextStyle(color: Colors.black),
                ),
              )
        ],
      )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey[700],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(widget.userName, style: TextStyle(fontSize: 17)),
              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(widget.email, style: TextStyle(fontSize: 17, )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
