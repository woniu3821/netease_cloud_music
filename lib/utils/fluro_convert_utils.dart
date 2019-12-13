import 'dart:convert';

class FluroConvertUtils {
  /// fluro 传递中文参数前，先转换，fluro 不支持中文传递
  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  //fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    var list = List<int>();

    //字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  // string 转为int
  static int string2int(String str) {
    return int.parse(str);
  }

  // string 转 double
  static double string2double(String str) {
    return double.parse(str);
  }

  //string 转 bool
  static bool string2bool(String str) {
    if (str == 'true') {
      return true;
    } else {
      return false;
    }
  }

  //object 转 string json
  static String object2string<T>(T t) {
    return fluroCnParamsEncode(jsonEncode(t));
  }

  // string json 转 map
  static Map<String, dynamic> string2map(String str) {
    return json.decode(fluroCnParamsDecode(str));
  }
}
