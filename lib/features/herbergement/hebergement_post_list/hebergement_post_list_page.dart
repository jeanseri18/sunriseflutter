import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/cubit/hebergement_cubit.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_detail/hebergement_detail_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_post/hebergement_post_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_search/herbergement_search_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class HebegementPostListPage extends StatefulWidget {
  const HebegementPostListPage(
      {super.key,
      required this.isexpireToken,
      required this.isSettingPageBack});
  final bool isexpireToken;

  final bool isSettingPageBack;

  @override
  State<HebegementPostListPage> createState() => _HebegementPostListPageState();
}

class _HebegementPostListPageState extends State<HebegementPostListPage> {
  @override
  void initState() {
    context.read<HebergementCubit>().getListHebergementById();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Mes annonces'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            widget.isSettingPageBack
                ? Navigator.push(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => HomeParentPage(
                        index: 4,
                        isexpireToken: widget.isexpireToken,
                      ),
                    ))
                : Navigator.pop(
                    context,
                  );
          },
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HebergementPostPage()),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    'ajouter une annonce',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              _buildHebergementListView(context)
              // _buildHebergementItem(context)
            ],
          ),
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
            return Center(
                child: Container(height: 250, child: Text(state.error)));
          }
          if (state is HebergementStateLoading) {}
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
                // color: Colors.amber,
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
