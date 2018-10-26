package com.example.restapiflutter

import android.app.Activity
import android.os.Bundle
import android.widget.Toast
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class NativeViewActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)
      //  GeneratedPluginRegistrant.registerWith(this)
        Toast.makeText(this, "in activity", Toast.LENGTH_LONG).show()
    }
}