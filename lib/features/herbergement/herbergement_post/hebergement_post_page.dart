import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HebergementPostPage extends StatefulWidget {
  const HebergementPostPage({super.key});

  @override
  State<HebergementPostPage> createState() => _HebergementPostPageState();
}

class _HebergementPostPageState extends State<HebergementPostPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  File? _coverImage;
  bool inProcess = false;
  final _emailController = TextEditingController();
  final _titreController = TextEditingController();
  final _prixController = TextEditingController();
  final _villeController = TextEditingController();
  final _communeController = TextEditingController();
  final _Controller = TextEditingController();
  final _email1Controller = TextEditingController();
  final picker = ImagePicker();

  List<File?> images = [null, null, null, null];

  Future<void> _getImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        images[index] = File(pickedFile.path);
      });
    }
  }

  void _deleteImage(int index) {
    _controller.reset();
    _controller.forward();
    setState(() {
      images[index] = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getImageWidget() {
    if (_coverImage != null) {
      return Image.file(
        _coverImage!,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return GestureDetector(
        onTap: () {
          getImage(ImageSource.gallery);
        },
        child: Container(
          width: 250,
          height: 250,
          color: Colors.grey,
        ),
      );
    }
  }

  getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: '',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      log(cropped!.path.toString());
      setState(() {
        _coverImage = File(cropped.path);
        inProcess = false;
      });
    } else {
      setState(() {
        inProcess = false;
      });
    }
  }

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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: images[index] == null
                              ? BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                              : null,
                          child: images[index] == null
                              ? IconButton(
                                  icon: const Icon(Icons.add_a_photo),
                                  onPressed: () => _getImage(index),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Image.file(
                                            images[index]!,
                                            fit: BoxFit.cover,
                                          )),
                                      Positioned(
                                        bottom: 8,
                                        right: 28,
                                        child: FadeTransition(
                                          opacity: _animation,
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      132, 5, 5, 5),
                                                  // border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Colors.white,
                                                iconSize: 30,
                                                onPressed: () =>
                                                    _deleteImage(index),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )));
                    },
                  ),
                ),
              ),
              const Text(
                'Detail du logement',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const Text(
                'Type de logement',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const Text(
                'Type de service',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const Text(
                'Prix',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _prixController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Localisation',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ville',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _villeController,
                ),
              ),
              const Text(
                'Commune',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _communeController,
                ),
              ),
              const Text(
                'Adresse',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Commodite',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Nbre de lit',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const Text(
                'nbre de piece',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
              const Text(
                'Nbre de personne',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 55,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ ne peut etre vide';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   context
                //       .read<LoginCubit>()
                //       .loginByMail(_emailController.text, _passwordController.text);
                // }
              },
              child: const Text(
                'Enregister',
                style: TextStyle(
                    fontSize: 17, fontFamily: 'Poppins', color: Colors.white),
              ),
            ),
          )),
    );
  }
}
