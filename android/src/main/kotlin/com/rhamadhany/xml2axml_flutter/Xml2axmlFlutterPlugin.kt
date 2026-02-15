package com.rhamadhany.xml2axml_flutter

import com.rhamadhany.xml2axml.AxmlUtils
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.io.File

/** Xml2axmlFlutterPlugin */
class Xml2axmlFlutterPlugin : FlutterPlugin, MethodCallHandler {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.rhamadhany/xml2axml_flutter")
        channel.setMethodCallHandler(this)
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        when (call.method) {
            "decodeXml" -> xmlParser(call, result, AxmlUtils::decode)

            "encodeXml" -> xmlParser(call, result, AxmlUtils::encode)
            else -> result.notImplemented()
        }
    }

    private fun xmlParser(
        call: MethodCall,
        result: MethodChannel.Result,
        parser: (File) -> Any
    ) {
        try {
            val filePath = call.argument<String>("file").run {
                this ?: throw Exception("Missing file path")
            }
            val file = File(filePath)
            val processedByteArray = parser(file)
            val xml = parser(file)
            result.success(xml)
        } catch (e: Exception) {
            result.error("ERROR", e.message, e.toString())
        }
    }
}
