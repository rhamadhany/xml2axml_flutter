import 'package:flutter/services.dart';

part 'xml2axml_flutter_impl.dart';

class Xml2axmlFlutter extends _Xml2axmlFlutterImpl {
  static final _instance = Xml2axmlFlutter._internal();

  Xml2axmlFlutter._internal();

  factory Xml2axmlFlutter() => _instance;

  @override
  Future<String?> decode(String filePath) async =>
      await methodChannel.invokeMethod("decodeXml", {"file": filePath});

  @override
  Future<Uint8List?> encode(String filePath) async =>
      await methodChannel.invokeMethod("encodeXml", {"file": filePath});
}
