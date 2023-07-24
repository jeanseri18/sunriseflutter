import 'package:flutter/material.dart';
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
                height: 40,
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
                  buildTypePROPERTY(context),
                  buildTypePROPERTY(context),
                  buildTypePROPERTY(context),
                  buildTypePROPERTY(context),
                ],
              ),
              Text(
                'Commodite',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Recherche',
            style: TextStyle(
                fontSize: 15, fontFamily: 'Poppins', color: Colors.white),
          ),
        ),
      ),
    );
  }

  Container buildTypePROPERTY(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      height: 100,
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
        '   item.text',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      )),
    );
  }
}
