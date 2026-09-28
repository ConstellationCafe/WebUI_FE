import 'model/penalty_log.dart';

List<int> cumulativeScoresForLogs({
  required List<PenaltyLog> logs,
  required bool newestFirst,
}) {
  final scores = <int>[];
  final runningByTarget = <String, int>{};

  if (newestFirst) {
    for (final log in logs) {
      final running = runningByTarget.putIfAbsent(
        log.targetDiscordId,
        () => log.targetCumulativeScore30d,
      );
      scores.add(running);
      if (!log.isCanceled) {
        final next = running - log.score;
        runningByTarget[log.targetDiscordId] = next < 0 ? 0 : next;
      }
    }
    return scores;
  }

  final pageTotals = <String, int>{};
  for (final log in logs) {
    if (!log.isCanceled) {
      pageTotals[log.targetDiscordId] =
          (pageTotals[log.targetDiscordId] ?? 0) + log.score;
    }
  }

  for (final log in logs) {
    final running = runningByTarget.putIfAbsent(log.targetDiscordId, () {
      final baseline =
          log.targetCumulativeScore30d - (pageTotals[log.targetDiscordId] ?? 0);
      return baseline < 0 ? 0 : baseline;
    });
    final next = log.isCanceled ? running : running + log.score;
    runningByTarget[log.targetDiscordId] = next;
    scores.add(next);
  }
  return scores;
}
