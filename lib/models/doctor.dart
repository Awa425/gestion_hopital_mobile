class Doctor {
  final int id;
  final String name;
  final String specialty;
  final String availability;
  final String imageUrl;
  final ConsultationLocation location;
  final String telephone;
  final String matricule;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.availability,
    required this.imageUrl,
    required this.location,
    required this.telephone,
    required this.matricule,
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
  teleconsultation,
}