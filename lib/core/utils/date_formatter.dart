import 'package:intl/intl.dart';

String formatSlotDay(DateTime value) => DateFormat('EEE d MMM').format(value);

String formatSlotTime(DateTime start, DateTime end) =>
    '${DateFormat.Hm().format(start)} – ${DateFormat.Hm().format(end)}';

String formatTimestamp(DateTime value) => DateFormat('d MMM, HH:mm:ss').format(value);
