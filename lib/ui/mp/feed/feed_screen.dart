import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_retiree/models/app_post.dart';
import 'package:smart_retiree/ui/mp/chatbot/chat_bot_screen.dart'
    show ChatBotScreen;
import 'package:smart_retiree/ui/mp/feed/post_view.dart';
import 'package:smart_retiree/ui/mp/feed/widgets/home_app_bar.dart';
import 'package:smart_retiree/utils/firebase_utils.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    // FirebaseUtils.clearAllEvents();
  }

  Stream<List<AppPost>> _postsStream() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppPost.fromMap(doc.id, doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: StreamBuilder<List<AppPost>>(
          stream: _postsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader.indicator(color: context.primary);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No posts available'));
            }

            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostView(post: post);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the post creation screen
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatBotScreen(),
              ));
        },
        backgroundColor: context.primary,
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
