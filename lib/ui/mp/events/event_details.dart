import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/app_event.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';
import 'package:smart_retiree/widgets/members_popup.dart';
import 'package:smart_retiree/widgets/shader_mask_wrapper.dart';
import 'package:smart_retiree/widgets/submit_button.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/image_from_url.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/string_extension.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final AppEvent event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late AppUser _currentUser;
  late AppEvent event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
    _currentUser = ref.read(userProvider)!;
  }

  void _joinEvent() async {
    try {
      Loader.show(true);
      final docRef =
          FirebaseFirestore.instance.collection('events').doc(event.id);

      if (!(event.members.contains(_currentUser.uid))) {
        final updated = [...event.members, _currentUser.uid];
        await docRef.update({'members': updated});
        setState(() {
          event = event.copyWith(members: updated);
        });
        CoreUtils.showToast(
            type: ToastType.success, message: 'Successfully joined');
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to join this event: $e');
    } finally {
      Loader.show(false);
    }
  }

  void _joinRevoke() async {
    try {
      Loader.show(true);
      final docRef =
          FirebaseFirestore.instance.collection('events').doc(event.id);

      if ((event.members.contains(_currentUser.uid))) {
        final updatedMembers =
            event.members.where((id) => id != _currentUser.uid).toList();
        await docRef.update({'members': updatedMembers});
        setState(() => event = event.copyWith(members: updatedMembers));
        CoreUtils.showToast(
            type: ToastType.success,
            message: 'Successfully revoke from this event');
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error,
          message: 'Failed to revoke from this event: $e');
    } finally {
      Loader.show(false);
    }
  }

  void _deleteEvent() async {
    try {
      Loader.show(true);
      final docRef =
          FirebaseFirestore.instance.collection('events').doc(event.id);

      await docRef.delete();
      CoreUtils.showToast(
          type: ToastType.success, message: 'Successfully delete event');
      CoreUtils.postFrameCall(() => Navigator.pop(context));
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to delete this event: $e');
    } finally {
      Loader.show(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Event Details",
        actions: [
          IconButton(
            icon: const ShaderMaskWrapper(
              child: Icon(
                MingCuteIcons.mgc_group_line,
                size: 25,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              CoreUtils.heroDialog(
                MembersPopup(
                  title: 'Event Joiners',
                  userIds: event.members,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageFromUrl.show(event.imageUrl, radius: 8),
            const SizedBox(height: 30),
            Text(
              event.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(MingCuteIcons.mgc_calendar_add_line, size: 18),
                const SizedBox(width: 8),
                Text(
                  event.time.formattedEventDate,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(MingCuteIcons.mgc_time_line, size: 18),
                const SizedBox(width: 8),
                Text(
                  event.time.formattedEventTime,
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
                  event.location,
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
                  event.type,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                event.description,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 40,
              width: double.infinity,
            ),
            if (event.createdBy != _currentUser.uid)
              Align(
                alignment: Alignment.center,
                child: SubmitButton(
                    onPressed: () {
                      if (event.members.contains(_currentUser.uid)) {
                        _joinRevoke();
                      } else {
                        _joinEvent();
                      }
                    },
                    label: event.members.contains(_currentUser.uid)
                        ? 'Revoke'
                        : 'Join Event'),
              ),
            if (event.createdBy == _currentUser.uid)
              Align(
                alignment: Alignment.center,
                child: SubmitButton(
                    onPressed: () {
                      _deleteEvent();
                    },
                    label: 'Delete Event'),
              ),
          ],
        ),
      ),
    );
  }
}
