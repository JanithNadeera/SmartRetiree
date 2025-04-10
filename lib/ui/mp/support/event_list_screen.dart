import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:smart_retiree/ui/mp/support/upload_event.dart';
import 'package:smart_retiree/ui/mp/support/widgets/chat_app_bar.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Map<String, dynamic>> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      Loader.show(true);

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final querySnapshot =
          await FirebaseFirestore.instance.collection('events').get();

      if (querySnapshot.docs.isNotEmpty) {
        final eventData = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'name': data['name'] ?? '',
            'time': data['datetime'] ?? '',
            'location': data['location'] ?? '',
            'type': data['type'] ?? '',
            'imageUrl': data['imageUrl'] ?? '',
          };
        }).toList();

        setState(() {
          events = eventData;
        });
      }
    } catch (e) {
      // Show error message if needed
      CoreUtils.showToast(
          type: ToastType.error, message: "Failed to load events");
    } finally {
      Loader.show(false);
    }
  }

  Color _getEventColor(String type) {
    switch (type) {
      case 'Education':
        return Colors.deepOrange.shade200;
      case 'Environment':
        return Colors.deepPurple.shade200;
      case 'Health':
        return Colors.pink.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  String _formatEventDateTime(String datetimeString) {
    try {
      final dateTime =
          DateTime.parse(datetimeString); // Parse the string into DateTime
      final date = DateFormat('yyyy/MM/dd').format(dateTime); // Format date
      final time =
          DateFormat('hh:mma').format(dateTime); // Format time (12-hour AM/PM)
      return 'Date: $date Time: $time';
    } catch (e) {
      return 'Invalid Date'; // In case of parsing error
    }
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
          ).then((onValue) {
            if (onValue != null) {
              setState(() {
                _loadEvents(); // Reload events after creating a new one
              });
            }
          });
        },
      ), // Assuming you have an EventAppBar widget
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final color = _getEventColor(event['type']!);

          String formattedDateTime = '';
          if (event['time'] is String) {
            formattedDateTime = _formatEventDateTime(event['time']);
          }

          return Card(
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['name'] ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              formattedDateTime,
                              style: const TextStyle(fontSize: 14),
                            ),
                            // Text(event['time'] ?? ''),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 6),
                            Text(event['location'] ?? ''),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            event['type'] ?? '',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Event Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      event['imageUrl'] ?? '',
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
