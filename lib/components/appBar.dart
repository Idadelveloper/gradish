import 'package:flutter/material.dart';
import 'package:gradish/providers/auth_provider.dart';

class GradishAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final AuthProvider authData;

  const GradishAppBar({Key? key, required this.title, required this.authData})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xffffc604),
        title: Text(title),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () async {
                    authData.logOut;
                  },
                  child: const Row(
                    children: [Icon(Icons.logout), Text("Logout")],
                  ),
                ),
              )
            ],
          )
        ]);
  }
}
