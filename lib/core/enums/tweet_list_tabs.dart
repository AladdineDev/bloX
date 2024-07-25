enum TweetListTab {
  forYou(
    title: 'For you',
  ),
  post(
    title: 'Post',
  ),
  following(
    title: 'Following',
  );

  const TweetListTab({required this.title});

  final String title;
}
