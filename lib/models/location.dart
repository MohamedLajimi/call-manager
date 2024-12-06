class Location {
  final String id;
  final double latitude;
  final double longitude;
  final int number;
  final String pseudo;

  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.number,
    required this.pseudo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'number': number,
      'pseudo': pseudo,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      number: int.parse(map['numero']),
      pseudo: map['pseudo'],
    );
  }
}
