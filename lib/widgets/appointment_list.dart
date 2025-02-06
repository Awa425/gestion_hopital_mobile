import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement real data fetching
    final List<Appointment> appointments = [
      Appointment(
        id: '1',
        patientName: 'Jean Dupont',
        doctorName: 'Dr. Martin',
        specialty: 'Cardiologie',
        dateTime: DateTime.now().add(const Duration(days: 2)),
      ),
    ];

    if (appointments.isEmpty) {
      return const Center(
        child: Text('Aucun rendez-vous programmé'),
      );
    }

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(appointment.patientName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${appointment.doctorName} - ${appointment.specialty}'),
                Text(
                  DateFormat.yMMMd('fr').add_Hm().format(appointment.dateTime),
                ),
              ],
            ),
            trailing: Chip(
              label: Text(
                appointment.status,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
