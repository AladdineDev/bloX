extension DurationFormatterExtension on Duration {
  String get formatted {
    final minutes = inMinutes;
    final seconds = inSeconds % 60;
    final formattedSeconds = seconds < 10 ? '0$seconds' : seconds;
    return '$minutes:$formattedSeconds';
  }
}
