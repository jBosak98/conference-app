import 'package:device_calendar/device_calendar.dart';

class ConferenceEvent {
  final String id;
  final String img;
  final String title;
  final String author;
  final DateTime startDate;
  final DateTime endDate;

  ConferenceEvent(
      this.id,
      this.img,
      this.title,
      this.author,
      this.startDate,
      this.endDate
      );
}

extension CalendarEvent on ConferenceEvent{
  Event toCalendarEvent(String calendarId){
    return Event(
        calendarId,
        title: this.title,
        start: this.startDate,
        end: this.endDate
    );
  }
}