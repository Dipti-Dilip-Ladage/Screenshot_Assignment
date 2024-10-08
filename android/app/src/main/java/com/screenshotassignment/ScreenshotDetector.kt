package com.screenshotassignment; // Change to your package name

import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.modules.core.DeviceEventManagerModule

class ScreenshotDetector(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    private val TAG: String = "ScreenshotDetector"

    private var context = reactContext
    private var screenshotObserver: ContentObserver? = null
    companion object {
        private const val TAG = "ScreenshotDetector"
    }

    init {
        startScreenshotObserver()
    }

    override fun getName(): String {
        return "ScreenshotDetector"
    }

    private fun startScreenshotObserver() {
        val handler = Handler(Looper.getMainLooper())
        screenshotObserver = object : ContentObserver(handler) {
            override fun onChange(selfChange: Boolean, uri: Uri?) {
                super.onChange(selfChange, uri)
                Log.d(TAG, "Media content has changed: $uri")

                if (uri != null) {
                    sendScreenshotDetectedEvent()
                }
            }
        }

        context.contentResolver.registerContentObserver(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            true,
            screenshotObserver!!
        )
    }

    private fun sendScreenshotDetectedEvent() {
        reactApplicationContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit("ScreenshotDetected", null)
        Log.d(TAG, "Screenshot event sent to JS");
    }

    @ReactMethod
    fun stopScreenshotObserver() {
        screenshotObserver?.let {
            context.contentResolver.unregisterContentObserver(it)
            screenshotObserver = null
        }
    }

    override fun onCatalystInstanceDestroy() {
        super.onCatalystInstanceDestroy()
        stopScreenshotObserver()
    }
}