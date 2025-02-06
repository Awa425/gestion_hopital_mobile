import 'package:flutter/material.dart';
import '../models/doctor.dart';
import 'package:intl/intl.dart';

class AppointmentSummaryScreen extends StatelessWidget {
  final Doctor doctor;
  final DateTime appointmentDateTime;
  final String appointmentReason;

  const AppointmentSummaryScreen({
    super.key,
    required this.doctor,
    required this.appointmentDateTime,
    required this.appointmentReason,
  });

  String _getConsultationTypeText(ConsultationType type) {
    switch (type) {
      case ConsultationType.hospital:
        return 'Hôpital';
      case ConsultationType.clinic:
        return 'Clinique';
      case ConsultationType.teleconsultation:
        return 'Téléconsultation';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE d MMMM yyyy', 'fr_FR');
    final timeFormat = DateFormat('HH:mm', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Récapitulatif du rendez-vous'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(doctor.imageUrl),
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Date',
                      dateFormat.format(appointmentDateTime),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.access_time,
                      'Heure',
                      timeFormat.format(appointmentDateTime),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.location_on,
                      _getConsultationTypeText(doctor.location.type),
                      doctor.location.name,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        doctor.location.address,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.description,
                      'Motif du rendez-vous',
                      appointmentReason,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Here you would typically send the booking to your backend
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rendez-vous confirmé avec succès !'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Navigate back to home
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Confirmer le rendez-vous'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Modifier le rendez-vous'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
