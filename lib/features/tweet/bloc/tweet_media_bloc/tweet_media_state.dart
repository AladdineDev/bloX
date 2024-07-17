part of 'tweet_media_bloc.dart';

enum TweetMediaStatus {
  initial,
  progress,
  success,
  failure,
}

class TweetMediaState extends Equatable {
  const TweetMediaState({
    this.status = TweetMediaStatus.initial,
    this.mediaList = const [],
    this.error = const UnknownException(),
  });

  final TweetMediaStatus status;
  final List<XFile> mediaList;
  final AppException error;

  TweetMediaState copyWith({
    TweetMediaStatus? status,
    List<XFile>? mediaList,
    AppException? error,
  }) {
    return TweetMediaState(
      status: status ?? this.status,
      error: error ?? this.error,
      mediaList: mediaList ?? this.mediaList,
    );
  }

  @override
  List<Object?> get props => [status, mediaList, error];
}
