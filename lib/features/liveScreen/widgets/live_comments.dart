import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zoc_lms_project/core/models/comment_model.dart';

// Firebase comment handling section
class LiveChat extends StatefulWidget {
  final String courseId;
  final String? videoId;

  const LiveChat({Key? key, required this.courseId, this.videoId})
      : super(key: key);

  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final _controller = TextEditingController();
  String newComment = '';
  bool loading = false;
  late DatabaseReference _chatRef;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();

    final chatPath =
        'livechat/${widget.courseId}/${widget.videoId ?? "general"}';
    _chatRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://classify-x-default-rtdb.asia-southeast1.firebasedatabase.app/')
        .ref()
        .child(chatPath);
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> handleAddComment() async {
    if (newComment.trim().isEmpty) {
      print('Comment is empty - not sending');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userName = prefs.getString('fullName') ?? "Anonymous";

      final newCommentRef = _chatRef.push();
      final commentData = {
        'user': userName,
        'content': newComment.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      await newCommentRef.set(commentData);

      setState(() {
        loading = false;
        newComment = '';
        _controller.clear();
      });
    } on FirebaseException catch (e) {
      setState(() {
        loading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to post comment: ${e.message}"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to post comment: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            onChanged: (text) => setState(() => newComment = text),
            decoration: InputDecoration(
              hintText: 'Type your message...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: handleAddComment,
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _chatRef.orderByChild('timestamp').onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData ||
                    snapshot.data?.snapshot.value == null) {
                  return const Center(
                    child: Text('No messages yet. Start the conversation!'),
                  );
                }

                List<Comment> comments = [];
                final data =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                data.forEach((key, value) {
                  if (value is Map) {
                    comments.add(Comment.fromMap(
                        key, Map<dynamic, dynamic>.from(value)));
                  }
                });

                comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

                return ListView.builder(
                  reverse: false,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          comment.user.length >= 2
                              ? comment.user.substring(0, 2).toUpperCase()
                              : comment.user.toUpperCase(),
                        ),
                      ),
                      title: Text(comment.user),
                      subtitle: Text(comment.content),
                      trailing: Text(
                        DateTime.parse(comment.timestamp)
                            .toLocal()
                            .toString()
                            .substring(0, 16),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
