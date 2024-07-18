enum TweetListTab {
  forYou(
    title: 'For you',
  ),
  following(
    title: 'Following',
  );

  const TweetListTab({required this.title});

  final String title;
}
