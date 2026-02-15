part of 'xml2axml_flutter.dart';

abstract class _Xml2axmlFlutterImpl {
  final methodChannel = MethodChannel("com.rhamadhany/xml2axml_flutter");

  Future<String?> decode(String filePath);

  Future<Uint8List?> encode(String filePath);
}
