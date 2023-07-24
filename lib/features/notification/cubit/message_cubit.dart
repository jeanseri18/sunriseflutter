import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/mesage_detail.dart';
import 'package:sunrise_hosting/data/model/message_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:sunrise_hosting/data/model/message_post_model.dart';
import 'package:sunrise_hosting/data/model/messsage_reply_model.dart';
import 'package:sunrise_hosting/data/provider/message_provider.dart';
part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  Future getMessageList() async {
    final MessageProvider _MessageProviderProvider = MessageProvider();
    emit(MessageStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _MessageProviderProvider.getListMessage();

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.data != null
            ? emit(MessageStateLoaded(result))
            : emit(MessageStateError('oups'));
      } else {
        emit(MessageStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(MessageStateError(e.toString()));
    }
  }

  Future getDetailMessageList(String id) async {
    final MessageProvider _MessageProviderProvider = MessageProvider();
    emit(MessageDetailStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _MessageProviderProvider.getDetailMessage(id);

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.status != null
            ? emit(MessageDetailStateLoaded(result))
            : emit(MessageDetailStateError('oups'));
      } else {
        emit(MessageDetailStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(MessageDetailStateError(e.toString()));
    }
  }
}

class MessageReplyCubit extends Cubit<MessageReplyState> {
  MessageReplyCubit() : super(MessageReplyInitial());
  Future getMessageReply(String id, String message) async {
    final MessageProvider _MessageProviderProvider = MessageProvider();
    emit(MessageReplyStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result =
            await _MessageProviderProvider.getReplyMessage(id, message);

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.status != null
            ? emit(MessageReplyStateLoaded(result))
            : emit(MessageReplyStateError('oups'));
      } else {
        emit(MessageReplyStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(MessageReplyStateError(e.toString()));
    }
  }

  Future getMessagePost(String message, String id_user_proprio) async {
    final MessageProvider _MessageProviderProvider = MessageProvider();
    emit(MessageReplyStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _MessageProviderProvider.getPostMessage(
            message, id_user_proprio);

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.status != null
            ? emit(MessagePostStateLoaded(result))
            : emit(MessageReplyStateError('oups'));
      } else {
        emit(MessageReplyStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(MessageReplyStateError(e.toString()));
    }
  }
}
