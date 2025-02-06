class Doctor {
  final String name;
  final String specialty;
  final String availability;
  final String imageUrl;
  final ConsultationLocation location;

  Doctor({
    required this.name,
    required this.specialty,
    required this.availability,
    required this.imageUrl,
    required this.location,
  });
}

class ConsultationLocation {
  final String name;
  final String address;
  final ConsultationType type;

  ConsultationLocation({
    required this.name,
    required this.address,
    required this.type,
  });
}

enum ConsultationType {
  hospital,
  clinic,
  teleconsultation
}
