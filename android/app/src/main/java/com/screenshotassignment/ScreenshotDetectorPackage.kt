package com.screenshotassignment; // Change to your package name

import android.view.View
import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ReactShadowNode
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class ScreenshotDetectorPackage : ReactPackage {
    override fun createNativeModules(reactContext: ReactApplicationContext): kotlin.collections.List<NativeModule> {
        val modules = mutableListOf<NativeModule>()
        modules.add(ScreenshotDetector(reactContext))
        return modules
    }

    override fun createViewManagers(reactContext: ReactApplicationContext): kotlin.collections.List<ViewManager<View, ReactShadowNode<*>>> {
        return emptyList()
    }
}