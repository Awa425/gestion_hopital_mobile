import 'package:flutter/material.dart';
import '../widgets/appointment_list.dart';
import 'new_appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre un rendez-vous'),
      ),
      body: const AppointmentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewAppointmentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
