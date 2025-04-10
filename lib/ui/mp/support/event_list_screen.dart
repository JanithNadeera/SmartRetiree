import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_retiree/models/app_event.dart';
import 'package:smart_retiree/ui/mp/support/upload_event.dart';
import 'package:smart_retiree/ui/mp/support/widgets/chat_app_bar.dart';
import 'package:smart_retiree/ui/mp/support/widgets/event_card.dart';
import 'package:smart_retiree/ui/mp/support/widgets/no_events.dart';
import 'package:smart_retiree/utils/loader.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  Stream<List<AppEvent>> _eventsStream() {
    return FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppEvent.fromMap(doc.id, doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventAppBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEventScreen(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: StreamBuilder<List<AppEvent>>(
          stream: _eventsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Loader.indicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading events'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return NoEvents(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateEventScreen(),
                    ),
                  );
                },
              );
            }

            final events = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(event: event);
              },
            );
          },
        ),
      ),
    );
  }
}
