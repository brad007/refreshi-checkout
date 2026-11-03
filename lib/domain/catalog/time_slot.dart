import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot.freezed.dart';

@freezed
abstract class TimeSlot with _$TimeSlot {
  const TimeSlot._();

  const factory TimeSlot({required String id, required DateTime startsAt, required DateTime endsAt}) = _TimeSlot;

  DateTime get day => DateTime(startsAt.year, startsAt.month, startsAt.day);
}
