import 'package:cloud_firestore/cloud_firestore.dart';

DateTime parseTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
}

DateTime parseTimestampOrIsoString(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return parseTimestamp(timestamp);
  } else if (timestamp is String) {
    return DateTime.parse(timestamp);
  } else {
    throw Exception('Invalid timestamp type');
  }
}
