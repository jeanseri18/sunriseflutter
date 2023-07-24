import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/features/notification/cubit/message_cubit.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';
import 'package:sunrise_hosting/features/reservation/reservation_form_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';

class hebergementDetailPage extends StatefulWidget {
  const hebergementDetailPage({super.key, required this.model});
  final Data model;
  @override
  State<hebergementDetailPage> createState() => _hebergementDetailPageState();
}

class _hebergementDetailPageState extends State<hebergementDetailPage> {
  bool wifiChecked = true;
  bool climatisationChecked = false;
  bool televisionChecked = false;
  bool cuisineChecked = true;
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        Assets.images.test.path,
                      )),
                  borderRadius: const BorderRadius.all(Radius.circular(0))),
              height: 280,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.model.titre!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.description!,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Commodités',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Wi-Fi gratuit',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].wifi == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // wifiChecked = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Climatisation',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].clim == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // climatisationChecked = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Télévision',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].tv == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // televisionChecked = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'gardien',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].gardien == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // cuisineChecked = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CheckboxListTile(
                          title: Text(
                            'parking',
                            style: TextStyle(fontSize: 13),
                          ),
                          value: widget.model.commodite?[0].parking == 1
                              ? true
                              : false,
                          onChanged: (value) {
                            setState(() {
                              // cuisineChecked = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hôte',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250,
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          maxLength: 600,
                                          decoration: InputDecoration(
                                            hintText: 'Entrez votre message ',
                                          ),
                                          controller: _textController,
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      ElevatedButton(
                                        child: Text('Envoyer'),
                                        onPressed: () {
                                          context
                                              .read<MessageReplyCubit>()
                                              .getMessagePost(
                                                  _textController.text,
                                                  widget.model.idUser
                                                      .toString());
                                          // Handle sending the message
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Discutez ',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Colors.blue),
                          ),
                        ),
                        title: Text(
                          widget.model.user?.name! ?? '',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                    ])),
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ReservationFormPage(
                          model: widget.model,
                        )),
              );
              // context.read<ReservationCubit>().getPostReservation( idHebergement:  widget.model.id.toString(), iduser:  widget.model.idUser.toString(), idpropio:  widget.model.user!.id!.toString(), dateDebut: dateDebut, montant: montant, dateFin: dateFin, reste: reste, avance: avance, nbrePerson: nbrePerson)
            },
            child: const Text(
              'Commandez ',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
