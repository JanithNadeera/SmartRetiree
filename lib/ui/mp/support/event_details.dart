import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_retiree/models/app_event.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/utils/string_extension.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final AppEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late AppUser _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = ref.read(userProvider)!;
  }

  // Future<void> _joinEvent(BuildContext context, String eventName) async {
  //   print("EVENT NAME: $eventName");

  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('events')
  //         .where('name', isEqualTo: eventName)
  //         .limit(1)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       final docRef = querySnapshot.docs.first.reference;
  //       print(querySnapshot.docs.first.data());
  //       await docRef.update({
  //         'joinedUsers': FieldValue.arrayUnion([_currentUser.uid]),
  //       });
  //       final updatedJoinedUsers =
  //           (await docRef.get()).data()?['joinedUsers'] ?? [];
  //       print("Updated joinedUsers List: $updatedJoinedUsers");

  //       setState(() {
  //         isJoined = true;
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Successfully joined the event!')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Event not found.')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to join event: $e')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.event.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.event.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              widget.event.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(
                  widget.event.time.formattedEventDateTime,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 18),
                const SizedBox(width: 8),
                Text(
                  widget.event.location,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.category, size: 18),
                const SizedBox(width: 8),
                Text(
                  widget.event.type,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              widget.event.description,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubmitButton(onPressed: () {}, label: 'Join Event'),
    );
  }
}
