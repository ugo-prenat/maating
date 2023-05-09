import 'dart:math';

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);
    final differenceMilliseconds =
        date2.millisecondsSinceEpoch - this.millisecondsSinceEpoch;
    if (differenceMilliseconds >= 31556952000) {
      return 'Il y a ${differenceMilliseconds ~/ 31556952000} ans';
    } else if (differenceMilliseconds >= 2629800000) {
      return 'Il y a ${differenceMilliseconds ~/ 2629800000} mois';
    } else if (differenceMilliseconds >= 604800000) {
      return 'Il y a ${differenceMilliseconds ~/ 604800000} semaines';
    } else if (differenceMilliseconds >= 86400000) {
      return 'Il y a ${differenceMilliseconds ~/ 86400000} jours';
    } else if (differenceMilliseconds >= 3600000) {
      return 'Il y a ${differenceMilliseconds ~/ 3600000} heures';
    } else if (differenceMilliseconds >= 60000) {
      return 'Il y a ${differenceMilliseconds ~/ 60000} minutes';
    } else if (differenceMilliseconds >= 1000) {
      return 'Il y a ${differenceMilliseconds ~/ 1000} secondes';
    } else {
      return 'À l\'instant';
    }
  }
}
