class CounterInfo {
  int value;
  DateTime lastUpdate;
  String userName;

  CounterInfo({
    required this.value,
    required this.lastUpdate,
    required this.userName,
  });

  CounterInfo.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        lastUpdate = DateTime.parse(json['lastUpdate']),
        userName = json['userName'];

  CounterInfo.toJson(Map<String, dynamic> json)
      : value = json['value'],
        lastUpdate = DateTime.parse(json['lastUpdate']),
        userName = json['userName'];

  Map<String, dynamic> toJson() => {
        'value': value,
        'lastUpdate': lastUpdate.toIso8601String(),
        'userName': userName,
      };
}
