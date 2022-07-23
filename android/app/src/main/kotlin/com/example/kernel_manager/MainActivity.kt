package com.example.kernel_manager

import android.os.SystemClock
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "penguin_kernel_manager"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            when {
                call.method.equals("getDeepSleep") -> {
                    result.success(getDeepSleep())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getDeepSleep(): Long {

        return (SystemClock.elapsedRealtime() - SystemClock.uptimeMillis()) / 10
    }
}
