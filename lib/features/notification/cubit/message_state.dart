part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageStateLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageStateLoaded extends MessageState {
  final MessageListModel response;
  MessageStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class MessageStateError extends MessageState {
  final String error;

  MessageStateError(this.error);
  @override
  List<Object> get props => [error];
}

class MessageDetailStateLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageDetailStateLoaded extends MessageState {
  final MessageDetailModel response;
  MessageDetailStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class MessageDetailStateError extends MessageState {
  final String error;

  MessageDetailStateError(this.error);
  @override
  List<Object> get props => [error];
}

abstract class MessageReplyState extends Equatable {
  const MessageReplyState();

  @override
  List<Object> get props => [];
}

class MessageReplyInitial extends MessageReplyState {}

class MessageReplyStateLoading extends MessageReplyState {
  @override
  List<Object> get props => [];
}

class MessageReplyStateLoaded extends MessageReplyState {
  final MessageReplyModel response;
  MessageReplyStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class MessagePostStateLoaded extends MessageReplyState {
  final MessagePostModel response;
  MessagePostStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class MessageReplyStateError extends MessageReplyState {
  final String error;

  MessageReplyStateError(this.error);
  @override
  List<Object> get props => [error];
}
