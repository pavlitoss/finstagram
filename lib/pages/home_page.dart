import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:finstagram/pages/feed_page.dart";
import "package:finstagram/pages/profile_page.dart";
import "package:finstagram/services/firebase_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  FirebaseService? _firebaseService;
  final List<Widget> _pages = [
    const FeedPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
          body: _pages[_currentPage],
          appBar: AppBar(
            //increase height of appbar
            toolbarHeight: 100,
            title: const Text(
              "Finstagram",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: _postImage,
                child: const Icon(Icons.add_a_photo, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    await _firebaseService!.logout();
                    Navigator.popAndPushNamed(context, "login");
                  },
                  child: const Icon(Icons.logout, color: Colors.white),
                ),
              ),
            ],
            backgroundColor: Colors.red,
          )),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (_index) {
        setState(() {
          _currentPage = _index;
        });
      },
      selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(label: "Feed", icon: Icon(Icons.feed)),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: "Profile"),
      ],
    );
  }

  void _postImage() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (_result == null) return;
    File _image = File(_result!.files.first.path!);
    await _firebaseService!.postImage(_image);
  }
}
