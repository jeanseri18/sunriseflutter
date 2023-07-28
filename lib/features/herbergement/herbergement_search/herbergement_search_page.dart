import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/hebergement_list_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class HebergementSearchPage extends StatefulWidget {
  const HebergementSearchPage({super.key});

  @override
  State<HebergementSearchPage> createState() => _HebergementSearchPageState();
}

class _HebergementSearchPageState extends State<HebergementSearchPage> {
  final _maxController = TextEditingController();
  final _minController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Recherche',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Prix min',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ce champ ne peut etre vide';
                        }

                        return null;
                      },
                      controller: _minController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Prix max',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ce champ ne peut etre vide';
                        }

                        return null;
                      },
                      controller: _maxController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Chambre',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Prix max',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champ ne peut etre vide';
                  }

                  return null;
                },
                controller: _maxController,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Type de propriete',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  buildTypePROPERTY(context, 'Hotel'),
                  buildTypePROPERTY(context, 'Residence meuble'),
                  buildTypePROPERTY(context, 'Location'),
                  buildTypePROPERTY(context, 'Autre'),
                ],
              ),
              Text(
                'Commodite',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
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
                      value: false,
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
                      value: false,
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
                      value: false,
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
                      value: false,
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
                  value: false,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HebergementlistPage(),
                  maintainState: false,
                ),
              );
            },
            child: const Text(
              'Recherche',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Container buildTypePROPERTY(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      height: 60,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromARGB(96, 140, 140, 140),
          width: 1,
        ),
      ),
      child: ListTile(
          title: Text(
        ' $title',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      )),
    );
  }
}
