String timeDiffToString(String timeDiff) {
  if (timeDiff.contains(' ')) {
    List<String> timeDiffList = timeDiff.split(' ');
    String days = timeDiffList[0];
    List<String> timeDiffHMS = timeDiffList[1].split(':');
    String hours = timeDiffHMS[0];
    String minutes = timeDiffHMS[1];
    String seconds = timeDiffHMS[2].split('.')[0];
    if (days != '0') {
      if (int.parse(days) >= 31) {
        return '오래전';
      }
      return '$days일 전';
    } else if (hours != '00') {
      return '${int.parse(hours).toString()}시간 전';
    } else if (minutes != '00') {
      return '${int.parse(minutes).toString()}분 전';
    } else {
      return '${int.parse(seconds).toString()}초 전';
    }
  } else {
    List<String> timeDiffHMS = timeDiff.split(':');
    String hours = timeDiffHMS[0];
    String minutes = timeDiffHMS[1];
    String seconds = timeDiffHMS[2].split('.')[0];
    if (hours != '00') {
      return '${int.parse(hours).toString()}시간 전';
    } else if (minutes != '00') {
      return '${int.parse(minutes).toString()}분 전';
    } else {
      return '${int.parse(seconds).toString()}초 전';
    }
  }
}
