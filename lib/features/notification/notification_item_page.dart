import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunrise_hosting/features/notification/cubit/message_cubit.dart';
import 'package:sunrise_hosting/features/notification/message_detail_page.dart';

class NotificationItemPage extends StatefulWidget {
  const NotificationItemPage({Key? key}) : super(key: key);

  @override
  State<NotificationItemPage> createState() => _NotificationItemPageState();
}

class _NotificationItemPageState extends State<NotificationItemPage> {
  @override
  void initState() {
    context.read<MessageCubit>().getMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state is MessageStateError) {
                // Gérer l'état d'erreur
              } else if (state is MessageStateLoading) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
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
                                  height: 70,
                                  child: ListTile(
                                    onTap: () {},
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "https://loremflickr.com/1234/2345/fashion",
                                      ),
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      color: Colors.grey[100],
                                    ),
                                    title: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          color: Colors.grey[100],
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 10,
                                          color: Colors.grey[100],
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  )));
                        }));
                // Afficher un indicateur de chargement
              } else if (state is MessageStateLoaded) {
                final messages = state.response.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Divider(),
                    ),
                    itemCount: messages!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = messages[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageDetailPage(
                                id: model.id!,
                                id_recever: model.latestMessageSender!.id!,
                              ),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.all(0),
                        leading: const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            "https://loremflickr.com/1234/2345/fashion",
                          ),
                        ),
                        subtitle: Text(
                          model.latestMessage?.message ?? '..............',
                          style: TextStyle(fontSize: 11),
                        ),
                        title: Row(
                          children: [
                            Text(
                              model.latestMessageSender?.name ?? 'invite',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Text(
                              'il y a ${model.date}',
                              style: TextStyle(fontSize: 11),
                            ),
                            SizedBox(width: 10),
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
    );
  }
}
