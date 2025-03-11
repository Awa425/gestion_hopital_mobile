import 'package:flutter/material.dart';
import '../models/medical_service.dart';
import 'doctor_list_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentReasonScreen extends StatefulWidget {
  const AppointmentReasonScreen({super.key});

  @override
  State<AppointmentReasonScreen> createState() => _AppointmentReasonScreenState();
}

class _AppointmentReasonScreenState extends State<AppointmentReasonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  MedicalService? _selectedService;
    List<MedicalService> _services = [];
  bool _isLoading = true;
  String? _errorMessage;
    @override
  void initState() {
    super.initState();
    _fetchServices();
  }

    // Récupération des services médicaux depuis l'API
  Future<void> _fetchServices() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

try {
    // Remplacez par l'URL de votre API
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/services'),
      headers: {
        // 'Authorization': 'Bearer $token', // Si vous avez un token d'authentification
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      
      // Vérifier si la requête a réussi selon votre structure de réponse
      if (responseData['success'] == true && responseData['data'] != null) {
        final List<dynamic> servicesData = responseData['data'];
        
        setState(() {
          _services = servicesData.map((serviceData) => MedicalService(
            id: serviceData['id'].toString(), // Conversion en String si nécessaire
            name: serviceData['libelle'] ?? 'Service sans nom',
            description: serviceData['description'] ?? 'Aucune description disponible',
            icon: 'healing', // Utiliser une icône par défaut puisque l'API n'en fournit pas
          )).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur dans la structure des données: ${responseData['message'] ?? 'Erreur inconnue'}';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Erreur lors de la récupération des services: ${response.statusCode}';
        _isLoading = false;
      });
    }
  } catch (e) {
    setState(() {
      _errorMessage = 'Impossible de se connecter au serveur: $e';
      _isLoading = false;
    });
  }
}



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
              'BidewTech',
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
