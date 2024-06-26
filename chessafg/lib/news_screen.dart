import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewsScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  void toggleLike(DocumentSnapshot doc) async {
    DocumentReference newsRef = FirebaseFirestore.instance.collection('news').doc(doc.id);

    DocumentSnapshot snapshot = await newsRef.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    List<dynamic> likes = data['likes'] ?? [];

    if (likes.contains(user!.uid)) {
      newsRef.update({
        'likes': FieldValue.arrayRemove([user!.uid])
      });
    } else {
      newsRef.update({
        'likes': FieldValue.arrayUnion([user!.uid])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('news').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              final String title = data['title'] ?? 'No Title';
              final String content = data['content'] ?? 'No Content';
              final String? imageUrl = data['imageUrl'];
              final List<dynamic> likes = data['likes'] ?? [];

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null) Image.network(imageUrl),
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(content),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Likes: ${likes.length}'),
                          IconButton(
                            icon: Icon(
                              likes.contains(user!.uid) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              color: likes.contains(user!.uid) ? Colors.blue : null,
                            ),
                            onPressed: () => toggleLike(doc),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CommentSection(newsId: doc.id),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final String newsId;

  CommentSection({required this.newsId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();

  void _postComment() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null || _commentController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('news').doc(widget.newsId).collection('comments').add({
      'userId': user.uid,
      'username': user.displayName ?? 'Anonymous',
      'comment': _commentController.text,
      'timestamp': Timestamp.now(),
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('news').doc(widget.newsId).collection('comments').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((doc) {
                final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                final String username = data['username'] ?? 'Anonymous';
                final String comment = data['comment'] ?? '';

                return ListTile(
                  title: Text(username),
                  subtitle: Text(comment),
                );
              }).toList(),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(labelText: 'Add a comment'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _postComment,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
