import 'package:device_calendar/device_calendar.dart';
import 'package:session/common/bloc/base_bloc.dart';
import 'package:session/ui/room/calendar_page.dart';

class CalendarBloc extends BaseBloc {

  Future<List<Result<String>>> exportEvents(List<String> eventsIds) async {
    final DeviceCalendarPlugin deviceCalendar = DeviceCalendarPlugin();
    final Result<List<Calendar>> calendars =
    await deviceCalendar.retrieveCalendars();

    final defaultCalendar =
    calendars.data.firstWhere((calendar) => calendar.isDefault);

    return await Future.wait(
        getEvents()
            .where((event) => eventsIds.contains(event.id))
            .map((event) => event.toCalendarEvent(defaultCalendar.id))
            .map((calendarEvent) =>
             deviceCalendar.createOrUpdateEvent(calendarEvent)));

  }

  List<ConferenceEvent> getEvents() {
    return [
      ConferenceEvent(
        "1",
        "images/me.jpg",
        "How to write Flutter app",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "2",
        "images/ja.jpg",
        "Docker security",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "3",
        "images/ja2.jpg",
        "Clojure - language of the future",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "4",
        "images/ja3.jpg",
        "Test Driven Development",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "5",
        "images/ja4.jpg",
        "Typescript - hot or not?",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "6",
        "images/ja4.jpg",
        "GraphQL - a query language for your API",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "7",
        "images/me.jpg",
        "Microservices architecture - introduction",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      ConferenceEvent(
        "8",
        "images/me.jpg",
        "How to write Flutter app",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
    ];
  }


}
