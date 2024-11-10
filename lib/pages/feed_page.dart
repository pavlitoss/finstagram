import "package:cloud_firestore/cloud_firestore.dart";
import "package:finstagram/services/firebase_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FirebaseService? _firebaseService;
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _deviceWidth,
      height: _deviceHeight,
      child: _postsListView(),
    );
  }

  Widget _postsListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getLatestPosts(),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          print(_snapshot.data.docs);
          List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
          return ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (BuildContext _context, int index) {
              Map _post = _posts[index];
              return Container(
                  height: _deviceHeight! * 0.3,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color.fromARGB(255, 138, 52, 52),
                          width: 10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_post["image"]))));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
