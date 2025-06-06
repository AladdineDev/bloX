part of 'tweet_media_bloc.dart';

sealed class TweetMediaEvent extends Equatable {
  const TweetMediaEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTweetMedia extends TweetMediaEvent {
  const GetAllTweetMedia();
}

final class AddTweetMedia extends TweetMediaEvent {
  const AddTweetMedia(this.media);

  final List<XFile> media;
}

class DeleteTweetMedia extends TweetMediaEvent {
  const DeleteTweetMedia(this.media);
  final XFile media;
}
