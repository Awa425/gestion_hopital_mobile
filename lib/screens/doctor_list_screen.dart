import 'package:flutter/material.dart';
import '../screens/booking_screen.dart';
import '../models/doctor.dart';
import '../models/medical_service.dart';
// import '../models/consultation_location.dart';

class DoctorListScreen extends StatelessWidget {
  final MedicalService selectedService;
  final String appointmentReason;

  const DoctorListScreen({
    super.key,
    required this.selectedService,
    required this.appointmentReason,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data - in a real app, this would come from an API and be filtered by service
    final doctors = [
      Doctor(
        name: 'Dr. Emily Carter',
        specialty: 'Cardiologie',
        availability: 'Disponible: Lun, Mer, Ven',
        imageUrl: 'assets/images/doctor1.jpg',
        location: ConsultationLocation(
          name: 'Hôpital Saint-Louis',
          address: '1 Avenue Claude Vellefaux, 75010 Paris',
          type: ConsultationType.hospital,
        ),
      ),
      Doctor(
        name: 'Dr. James Holloway',
        specialty: 'Neurologie',
        availability: 'Disponible: Mar, Jeu',
        imageUrl: 'assets/images/doctor2.jpg',
        location: ConsultationLocation(
          name: 'Clinique du Parc',
          address: '155 Ter Boulevard Victor Hugo, 92110 Clichy',
          type: ConsultationType.clinic,
        ),
      ),
      Doctor(
        name: 'Dr. Lisa Kim',
        specialty: 'Pédiatrie',
        availability: 'Disponible: Lun, Jeu, Sam',
        imageUrl: 'assets/images/doctor3.jpg',
        location: ConsultationLocation(
          name: 'Téléconsultation',
          address: 'Consultation en ligne via notre plateforme sécurisée',
          type: ConsultationType.teleconsultation,
        ),
      ),
    ].where((doctor) => doctor.specialty == selectedService.name).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.local_hospital,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'HealthSchedule',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedService.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Motif: $appointmentReason',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: doctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucun médecin disponible pour ${selectedService.name}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(doctor.imageUrl),
                                backgroundColor: Colors.grey[200],
                                child: doctor.imageUrl.startsWith('assets/')
                                    ? null
                                    : Icon(Icons.person,
                                        size: 40, color: Colors.grey[400]),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.specialty,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.availability,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.location.name,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.location.address,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                        doctor: doctor,
                                        appointmentReason: appointmentReason,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Voir détails'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
