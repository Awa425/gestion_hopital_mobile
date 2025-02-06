import 'package:flutter/material.dart';
import '../models/medical_service.dart';
import 'doctor_list_screen.dart';

class AppointmentReasonScreen extends StatefulWidget {
  const AppointmentReasonScreen({super.key});

  @override
  State<AppointmentReasonScreen> createState() => _AppointmentReasonScreenState();
}

class _AppointmentReasonScreenState extends State<AppointmentReasonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  MedicalService? _selectedService;

  // Sample medical services - in a real app, this would come from an API
  final List<MedicalService> _services = [
    MedicalService(
      id: '1',
      name: 'Cardiologie',
      description: 'Traitement des maladies du cœur et des vaisseaux sanguins',
      icon: 'favorite',
    ),
    MedicalService(
      id: '2',
      name: 'Neurologie',
      description: 'Traitement des maladies du système nerveux',
      icon: 'psychology',
    ),
    MedicalService(
      id: '3',
      name: 'Pédiatrie',
      description: 'Soins médicaux pour les enfants',
      icon: 'child_care',
    ),
    MedicalService(
      id: '4',
      name: 'Dermatologie',
      description: 'Traitement des maladies de la peau',
      icon: 'healing',
    ),
    MedicalService(
      id: '5',
      name: 'Ophtalmologie',
      description: 'Traitement des maladies des yeux',
      icon: 'visibility',
    ),
    MedicalService(
      id: '6',
      name: 'Dentisterie',
      description: 'Soins dentaires et buccaux',
      icon: 'cleaning_services',
    ),
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedService != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DoctorListScreen(
            selectedService: _selectedService!,
            appointmentReason: _reasonController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sélectionnez un service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  final isSelected = service == _selectedService;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedService = service;
                      });
                    },
                    child: Card(
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(
                                  int.parse('0xe${service.icon.hashCode.toString().substring(0, 3)}'),
                                  fontFamily: 'MaterialIcons'),
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              service.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              if (_selectedService != null) ...[
                const Text(
                  'Motif du rendez-vous',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Décrivez vos symptômes ou la raison de votre visite',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le motif de votre rendez-vous';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Continuer'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
