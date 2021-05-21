class Event {
  final String title;
  final String description;
  final DateTime from;
  final double duration;
  final String location;
  Event(
      {required this.from,
      required this.duration,
      required this.location,
      required this.title,
      required this.description});
}
