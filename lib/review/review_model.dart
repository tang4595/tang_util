class UtilReviewModel {
  UtilReviewModel({
      String? latest,
  }) {
    _latest = latest;
  }

  UtilReviewModel.fromJson(dynamic json) {
    _latest = json['latest'];
  }

  String? _latest;

  UtilReviewModel copyWith({
    String? latest,
  }) => UtilReviewModel(
    latest: latest ?? _latest,
  );

  String? get latest => _latest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latest'] = _latest;
    return map;
  }
}