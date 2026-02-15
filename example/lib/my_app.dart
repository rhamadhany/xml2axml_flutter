import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:xml2axml_flutter/xml2axml_flutter.dart';

enum LastSession { decode, encode }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final xml2axml = Xml2axmlFlutter();

  final filePicker = FilePicker.platform;

  bool _isLoading = false;
  dynamic output = '';

  String? lastPicked;

  LastSession _lastSession = .decode;

  Size get _size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xml2aml Example"),
        actions: [
          if (output.isNotEmpty)
            IconButton(onPressed: saveToFile, icon: Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : output.isEmpty
          ? Center(child: button())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    height: _size.height * 0.8,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Text(output.toString()),
                    ),
                  ),
                  Flexible(child: button()),
                ],
              ),
            ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: .center,
        spacing: 10,
        children: [
          TextButton(onPressed: decode, child: Text("Decode")),
          TextButton(onPressed: encode, child: Text("Encode")),
        ],
      ),
    );
  }

  void decode() async {
    String? path = await filePath();
    setState(() {
      _isLoading = true;
      _lastSession = .decode;
    });
    if (path != null) {
      final result = await xml2axml.decode(path);
      setState(() {
        if (result != null) {
          output = result;
        }
        _isLoading = false;
      });
    }
  }

  void encode() async {
    String? path = await filePath();
    setState(() {
      _isLoading = true;
      _lastSession = .encode;
    });
    if (path != null) {
      final result = await xml2axml.encode(path);
      setState(() {
        if (result != null) {
          output = result;
        }
        _isLoading = false;
      });
    }
  }

  Future<String?> filePath() async {
    final picker = await filePicker.pickFiles(
      dialogTitle: "Pick xml file",
      allowMultiple: false,
    );
    var path = picker?.files.single.path;
    lastPicked = picker?.files.single.name;
    return path;
  }

  void saveToFile() {
    if (lastPicked == null) return;
    final name = _extractedName(lastPicked!);
    final fileName =
        "${name.$1} ${_lastSession == .decode ? "_decode" : "_encode"}.${name.$2}";

    filePicker.saveFile(
      dialogTitle: "Save xml file",
      fileName: fileName,
      bytes: output is String ? Uint8List.fromList(output.codeUnits) : output,
    );
  }

  (String, String) _extractedName(String path) {
    final split = path.split('.');
    return (split.first, split.last);
  }
}
