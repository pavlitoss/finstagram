import "package:cloud_firestore/cloud_firestore.dart";
import "package:finstagram/services/firebase_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

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
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileImage(),
          _postsGridView(),
        ],
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          height: _deviceHeight! * 0.15,
          width: _deviceHeight! * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image:
                      NetworkImage(_firebaseService!.currentUser!["image"]))),
        ),
        Text(_firebaseService!.currentUser!["name"],
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))
      ]),
    );
  }

  Widget _postsGridView() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService!.getPostsForUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List _posts = snapshot.data!.docs.map((e) => e.data()).toList();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    Map _post = _posts[index];
                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_post["image"]))));
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            }));
  }
}
