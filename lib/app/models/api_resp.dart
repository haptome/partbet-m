class ApiResp {
  ApiResp.fromJson(Map<String, dynamic> map)
      : errCode = map['errCode'] as int,
        errMsg = map['errMsg'] as String,
        data = map['data'];
  int errCode;
  String errMsg;
  dynamic data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errCode'] = errCode;
    data['errMsg'] = errMsg;
    data['data'] = data;
    return data;
  }
}
