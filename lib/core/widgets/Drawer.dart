import 'package:dukaandaar/core/config/theme.dart';
import 'package:flutter/material.dart';

MyDrawer(
    {required GlobalKey<ScaffoldState> key, required name, required version}) {
  return StatefulBuilder(builder: (contex, setState) {
    return Drawer(
      child: SafeArea(
        child: SizedBox(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20, left: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        key.currentState!.openEndDrawer();
                                        // Get.toNamed('/user_profile');
                                      },
                                      child: Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                          color: AppConstants.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 51,
                                            width: 51,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text("A"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 200, child: Text('${name!}')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "Quote SPace",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(),

                    //home
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        key.currentState!.openEndDrawer();
                      },
                    ),

                    //Certificates
                    ListTile(
                      leading: Icon(Icons.document_scanner_outlined),
                      title: Text('Performance Index'),
                      onTap: () {
                        key.currentState!.openEndDrawer();
                        // Get.toNamed("/certificates");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About Us'),
                      onTap: () {
                        key.currentState!.openEndDrawer();
                        // Get.to(HtmlText(
                        //   title: 'About Us',
                        //   url: '${baseUrl}/aboutApp',
                        // ));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.policy),
                      title: Text('Privacy Policy'),
                      onTap: () {
                        key.currentState!.openEndDrawer();
                        // Get.to(HtmlText(
                        //   title: 'Privacy Policy',
                        //   url: '${baseUrl}/privacyApp',
                        // ));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        key.currentState!.openEndDrawer();
                        // MyDialogs.mainConfirmDialog(
                        //     content: 'Are you sure you want to logout?',
                        //     callback: () {
                        //       logout();
                        //     });
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Version $version',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  });
}
