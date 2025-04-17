import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/app_event.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';
import 'package:smart_retiree/widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/ui/mp/events/upload_event.dart';
import 'package:smart_retiree/ui/mp/events/widgets/event_card.dart';
import 'package:smart_retiree/ui/mp/events/widgets/no_events.dart';
import 'package:smart_retiree/utils/loader.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
      appBar: CustomAppBar(
        title: "Events",
        withShader: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEventScreen(),
                ),
              );
            },
            icon: const ShaderMaskWrapper(
              child: Icon(
                MingCuteIcons.mgc_add_circle_line,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
