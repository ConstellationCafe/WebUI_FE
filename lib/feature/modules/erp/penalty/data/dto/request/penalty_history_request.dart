import 'package:constellation_cafe/feature/modules/erp/penalty/domain/type/penalty_history_sort.dart';

class PenaltyHistoryRequest {
  final String? channelId;
  final String? discordId;
  final String sort;
  final int page;
  final int size;

  const PenaltyHistoryRequest({
    this.channelId,
    this.discordId,
    this.sort = PenaltyHistorySort.newest,
    this.page = 1,
    this.size = 20,
  });

  Map<String, dynamic> toJson() => {
    if (channelId != null && channelId!.isNotEmpty) 'channelId': channelId,
    if (discordId != null && discordId!.isNotEmpty) 'discordId': discordId,
    'sort': sort,
    'page': page,
    'size': size,
  };
}
