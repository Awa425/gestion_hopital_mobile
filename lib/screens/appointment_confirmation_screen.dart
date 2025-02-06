import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/doctor.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  final String selectedTime;
  final String appointmentReason;

  const AppointmentConfirmationScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.appointmentReason,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE d MMMM yyyy', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation du rendez-vous'),
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
                    const Text(
                      'Détails du rendez-vous',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow(
                      Icons.person,
                      'Médecin',
                      doctor.name,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.medical_services,
                      'Spécialité',
                      doctor.specialty,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Date',
                      dateFormat.format(selectedDate),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.access_time,
                      'Heure',
                      selectedTime,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.location_on,
                      'Lieu',
                      '${doctor.location.name}\n${doctor.location.address}',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.description,
                      'Motif',
                      appointmentReason,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Ici, vous ajouteriez la logique pour sauvegarder le rendez-vous
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Votre rendez-vous a été confirmé !'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Retourner à l'écran d'accueil
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmer le rendez-vous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.edit),
              label: const Text('Modifier la date ou l\'heure'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Theme.of(context).primaryColor),
                foregroundColor: Theme.of(context).primaryColor,
              ),
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
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
