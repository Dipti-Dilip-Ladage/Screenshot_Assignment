package com.screenshotassignment

import android.app.Activity
import android.view.WindowManager
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class ScreenshotModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    private var isSecureModeEnabled = false

    override fun getName(): String {
        return "ScreenshotModule"
    }

    @ReactMethod
    fun enableSecureMode() {
        val currentActivity: Activity? = currentActivity
        currentActivity?.runOnUiThread {
            currentActivity.window.setFlags(
                WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE
            )
            isSecureModeEnabled = true
        }
    }

    @ReactMethod
    fun disableSecureMode() {
        val currentActivity: Activity? = currentActivity
        currentActivity?.runOnUiThread {
            currentActivity.window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
            isSecureModeEnabled = false
        }
    }

    @ReactMethod
    fun isSecureModeEnabled(): Boolean {
        return isSecureModeEnabled
    }
}

