import 'package:blox/core/exceptions/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'tweet_media_event.dart';
part 'tweet_media_state.dart';

class TweetMediaBloc extends Bloc<TweetMediaEvent, TweetMediaState> {
  TweetMediaBloc() : super(const TweetMediaState()) {
    on<GetAllTweetMedia>(_onGetAllTweetMedia);
    on<AddTweetMedia>(_onAddTweetMedia);
    on<DeleteTweetMedia>(_onDeleteTweetMedia);
  }

  static const maxMediaPicked = 4;

  _onGetAllTweetMedia(
    GetAllTweetMedia event,
    Emitter<TweetMediaState> emit,
  ) {
    emit(state);
  }

  _onAddTweetMedia(
    AddTweetMedia event,
    Emitter<TweetMediaState> emit,
  ) {
    emit(
      state.copyWith(
        mediaList: [...state.mediaList, ...event.media],
      ),
    );
  }

  _onDeleteTweetMedia(
    DeleteTweetMedia event,
    Emitter<TweetMediaState> emit,
  ) {
    emit(
      state.copyWith(
        mediaList: [...state.mediaList]..remove(event.media),
      ),
    );
  }
}
