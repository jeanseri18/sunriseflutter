import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/features/paiment/paiment_history/cubit/paiment_cubit.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class PaimentHistoryPage extends StatefulWidget {
  const PaimentHistoryPage({super.key, required this.isexpireToken});

  final bool isexpireToken;
  @override
  State<PaimentHistoryPage> createState() => _PaimentHistoryPageState();
}

class _PaimentHistoryPageState extends State<PaimentHistoryPage> {
  @override
  void initState() {
    context.read<PaymentCubit>().getPaymentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historique de paiement',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) => HomeParentPage(
                    index: 4,
                    isexpireToken: widget.isexpireToken,
                  ),
                ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentStateError) {
                    // Gérer l'état d'erreur
                  } else if (state is PaymentStateLoading) {
                    // Afficher un indicateur de chargement
                  } else if (state is PaymentStateLoaded) {
                    final Payments = state.response.data;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Divider(),
                        ),
                        itemCount: Payments!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final model = Payments[index];
                          return ListTile(
                            title: Text('Payement  N° ${model.id}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Avance ' +
                                    model.reservation!.avance.toString() +
                                    ' FCFA'),
                                Text('reste a payer ' +
                                    model.reservation!.reste.toString() +
                                    ' FCFA'),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text(model.montant.toString() + ' FCFA'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(model.date.toString()),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
