import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_retiree/utils/user_role_selector.dart';

extension StringExt on String {
  UserRole get role {
    return switch (this) {
      'retiree' => UserRole.retiree,
      'seeker' => UserRole.seeker,
      _ => UserRole.retiree,
    };
  }
}

extension EventTypeColor on String {
  Color get eventColor {
    switch (this) {
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
}

extension EventDateTimeFormat on DateTime {
  String get formattedEventDateTime {
    try {
      final date = DateFormat('yyyy/MM/dd').format(this); // Format date
      final time =
          DateFormat('hh:mma').format(this); // Format time (12-hour AM/PM)
      return 'Date: $date Time: $time';
    } catch (e) {
      return 'Invalid Date'; // In case of parsing error
    }
  }
}

extension InitialsExtension on String {
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words.first[0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}

extension TimeAgoExtension on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }
}
