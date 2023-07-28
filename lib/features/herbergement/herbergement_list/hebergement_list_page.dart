import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_detail/hebergement_detail_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/cubit/hebergement_cubit.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';

import '../../../data/model/hebergement_list_model.dart';

class HebergementlistPage extends StatefulWidget {
  const HebergementlistPage({super.key});

  @override
  State<HebergementlistPage> createState() => _HebergementlistPageState();
}

class _HebergementlistPageState extends State<HebergementlistPage> {
  @override
  void initState() {
    context.read<HebergementCubit>().getHebergementList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text('Liste des resulats '),
              trailing: Icon(Icons.menu),
            ),
            _buildHebergementListView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildHebergementListView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 168,
      child: BlocBuilder<HebergementCubit, HebergementState>(
        builder: (context, state) {
          if (state is HebergementStateError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  // color: Colors.amber.shade100,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Oups , une erreur s est produite',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.height,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: (() => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeParentPage(
                                      isexpireToken: false,
                                      index: 0,
                                    ),
                                    maintainState: false,
                                  ),
                                  (route) => true,
                                )),
                            child: const Text(
                              'Reesayer',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors
                                    .black, // Changed the text color to black for better visibility
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }
          if (state is HebergementStateLoading) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 310,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
          }
          if (state is HebergementStateLoaded) {
            inspect(state.response.data!.length);
            return ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.response.data!.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    child: _buildHebergementItem(
                        context, state.response.data![index]));
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHebergementItem(BuildContext context, Data model) {
    var image = model.images;

// Utilisez imageUrl pour afficher l'image dans votre code

    return SizedBox(
      height: 310,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return hebergementDetailPage(
                  model: model,
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                image: image?.isNotEmpty ?? true
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'http://sunrise-housing.net/storage/' +
                                image!.first.fileUrl!),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.images.test.path),
                      ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              height: 220,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.titre ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(model.commune ?? '' + ', ' + model.ville!),
            Text(
              model.prix.toString() + ' FCFA',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
