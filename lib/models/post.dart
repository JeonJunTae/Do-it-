import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime createdtime;
  final String postUrl;
  final int likecount;
  final int commentcount;
  final int viewcount;

  Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.createdtime,
    required this.postUrl,
    required this.likecount,
    required this.commentcount,
    required this.viewcount,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'createdDate': createdtime,
        'likes': likecount,
        'postUrl': postUrl,
        'comments': commentcount,
        'views': viewcount,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      createdtime: snapshot['createdtime'],
      likecount: snapshot['likes'],
      postUrl: snapshot['postUrl'],
      commentcount: snapshot['comments'],
      viewcount: snapshot['views'],
    );
  }
}
