import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';
import 'package:sunrise_hosting/widget/loader_widget.dart';

class ReservationFormPage extends StatefulWidget {
  final Data model;

  ReservationFormPage({required this.model});

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateDebutController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _dateFinController = TextEditingController();
  final TextEditingController _resteController = TextEditingController();
  final TextEditingController _avanceController = TextEditingController();
  final TextEditingController _nbrePersonController = TextEditingController();

  DateTime? _selectedDateDebut;
  DateTime? _selectedDateFin;
  double total = 0;
  void _updateTotal() {
    if (_montantController.text.isNotEmpty &&
        _nbrePersonController.text.isNotEmpty) {
      double montant = double.parse(_montantController.text);
      int nbrePerson = int.parse(_nbrePersonController.text);
      setState(() {
        total = montant * nbrePerson;
      });
    } else {
      setState(() {
        total = 0;
      });
    }
  }

  @override
  void initState() {
    // ...

    // Ajouter un écouteur pour les changements de texte des champs "Montant" et "Nombre de personne"
    _montantController.addListener(_updateTotal);
    _nbrePersonController.addListener(_updateTotal);

    super.initState();
  }

  @override
  void dispose() {
    _dateDebutController.dispose();
    _montantController.dispose();
    _dateFinController.dispose();
    _resteController.dispose();
    _avanceController.dispose();
    _nbrePersonController.dispose();
    super.dispose();
  }

  Future<void> _selectDateDebut() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(
          days:
              365)), // Permet de sélectionner une date jusqu'à un an à l'avance
    );
    if (picked != null && picked != _selectedDateDebut) {
      setState(() {
        _selectedDateDebut = picked;
        _dateDebutController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateFin() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(
          days:
              365)), // Permet de sélectionner une date jusqu'à un an à l'avance
    );
    if (picked != null && picked != _selectedDateFin) {
      setState(() {
        _selectedDateFin = picked;
        _dateFinController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Formulaire de réservation'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ... Autres champs du formulaire ...
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _dateDebutController,
                      readOnly: true,
                      onTap: _selectDateDebut,
                      decoration: InputDecoration(
                        labelText: 'Date de début',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner une date de début';
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(),
                  // Champ de date de fin
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _dateFinController,
                      readOnly: true,
                      onTap: _selectDateFin,
                      decoration: InputDecoration(
                        labelText: 'Date de fin',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner une date de fin';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.person_2_outlined),
                  label: Text('Montant'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champ ne peut etre vide';
                  }

                  return null;
                },
                controller: _montantController,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.person_2_outlined),
                  label: Text('Avance'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champ ne peut etre vide';
                  }

                  return null;
                },
                controller: _resteController,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.person_2_outlined),
                  label: Text('Reste'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champ ne peut etre vide';
                  }

                  return null;
                },
                controller: _avanceController,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.person_2_outlined),
                  label: Text('Nombre de personne'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champ ne peut etre vide';
                  }
                  setState(() {
                    total = double.parse(_montantController.text) *
                        double.parse(_nbrePersonController.text);
                  });

                  return null;
                },
                controller: _nbrePersonController,
              ),
              Divider(),
              Row(
                children: [
                  Text('TOTAL a PAYER'),
                  Spacer(),
                  Text('${total.toDouble()}')
                ],
              ),
              // ... Autres champs du formulaire ...

              const SizedBox(height: 16),
              SizedBox(
                  height: 80,
                  child: BlocConsumer<ReservationCubit, ReservationState>(
                      builder: (context, state) {
                    if (state is ReservationStateError) {
                      return Card(
                        color: Colors.red,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            state.error,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    if (state is ReservationStateLoaded) {
                      return Card(
                        color: Colors.green,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Votre demande de visite a été annulée!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                    if (state is ReservationStateLoading) {
                      return Center(child: LoaderWidget());
                    }
                    return Container();
                  }, listener: (context, state) {
                    if (state is ReservationStateError) {
                      // Navigator.canPop(context);
                      // setState(() {
                      //   isok = true;
                      // });
                    }

                    if (state is ReservationStateLoaded) {}
                  })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<ReservationCubit>().getPostReservation(
                  idHebergement: widget.model.id.toString(),
                  iduser: widget.model.idUser.toString(),
                  idpropio: widget.model.user!.id!.toString(),
                  dateDebut: _dateDebutController.text,
                  montant: widget.model.prix.toString(),
                  dateFin: _dateFinController.text,
                  reste: _resteController.text,
                  avance: _avanceController.text,
                  nbrePerson: _nbrePersonController.text);
            },
            child: const Text('Valider'),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 120,
        child: BlocConsumer<ReservationCubit, ReservationState>(
          listener: (context, state) {
            // if (state is ReservationPostStateError) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.error)),
            //   );
            // } else
            if (state is ReservationPostStateLoaded) {
              _navigateBackWithDelay(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Votre demande de réservation a été effectuée avec succès!')),
              );
            }
          },
          builder: (context, state) {
            if (state is ReservationPostStateLoading) {
              return BottomSheet(
                onClosing: () {},
                builder: (context) => Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (state is ReservationPostStateLoaded) {
              return Container();
              //  BottomSheet(
              // backgroundColor: Color.fromARGB(255, 174, 177, 174),
              //   onClosing: () {},
              //   builder: (context) => Container(
              //     padding: EdgeInsets.all(16),
              //     child: Center(
              //         child: Text(
              //             'Votre demande de réservation a été effectuée avec succès!')),
              //   ),
              // );
            }
            if (state is ReservationPostStateError) {
              return Container();
              // BottomSheet(
              //   // backgroundColor: Color.fromARGB(255, 174, 177, 174),
              //   onClosing: () {},
              //   builder: (context) => Container(
              //     padding: EdgeInsets.all(16),
              //     child: Center(
              //         child: Text(
              //             'Votre demande de réservation ne peut etre effectuée !')),
              //   ),
              // );
            }
            return Container(); // Retourner un conteneur vide par défaut
          },
        ),
      ),
    );
  }
}

Future<void> _navigateBackWithDelay(BuildContext context) async {
  // Attendre pendant 5 secondes avant de retourner à la page précédente
  await Future.delayed(Duration(seconds: 5));

  // Naviguer à la page précédente
  Navigator.pop(context);
}
