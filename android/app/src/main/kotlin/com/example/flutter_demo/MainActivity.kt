package com.example.flutter_demo

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec

class MainActivity : FlutterActivity(), BasicMessageChannel.MessageHandler<String> {


    lateinit var channel: BasicMessageChannel<String>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        ///methodChannel
        val methodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "methodChannel")

        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->

            println(call.method)
            println(call.arguments)

            if (call.method == "getAppVersion") {
                result.success("1.0.0")
            }
        }




        channel = BasicMessageChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "messageChannel",
            StringCodec.INSTANCE
        )

        channel.setMessageHandler(this)
        channel.send("hi hi")


        //1
        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "eventChannel")

        //2
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {


                Handler(Looper.getMainLooper()).postDelayed({
                    events?.success("来自Android的消息")
                }, 1000)

            }

            override fun onCancel(arguments: Any?) {
            }

        })


    }

    override fun onMessage(message: String?, reply: BasicMessageChannel.Reply<String>) {

        println("收到来自Flutter的消息:$message")
        channel.send("haha flutter")
        channel.send("hi")
        reply.reply("holle android")

    }


}
