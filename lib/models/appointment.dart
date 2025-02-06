class Appointment {
  final String id;
  final String patientName;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String status;

  Appointment({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    this.status = 'En attente',
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientName: json['patientName'],
      doctorName: json['doctorName'],
      specialty: json['specialty'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'doctorName': doctorName,
      'specialty': specialty,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
    };
  }
}
