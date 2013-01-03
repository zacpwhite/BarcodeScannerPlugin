BarcodeScannerPlugin
====================

Cross platform Phonegap/Cordova Plugin of the Scandit Barcode Scanner SDK

Follow the detailed instructions below to add a high-performance barcode scanner to your app in less than 30 minutes.



How to integrate the Scandit SDK into your own iOS Phonegap App
------------------------

* Download and add the Scandit SDK for iOS library to your Xcode Cordova Project:
    * Sign up for a free community license (or one of the enterprise packages) at http://www.scandit.com. 
    * Download the latest Scandit SDK version for iOS from your Scandit account. 
    * Unzip the downloaded zip file and copy the ScanditSDK folder into your Phonegap/Cordova project (i.e. into the same folder where you also have the Plugins, Resources and Classes folder)
    * Open your project in Xcode, right-click on your project in the navigation pane and select "Add Files to <name of your project>" 
    * Choose the ScanditSDK folder you copied in the step above (make sure you select the option "create group for added folders")

* Add this plugin to your Xcode Cordova Project:
    * Copy the four files from this Github Plugin folder (ScanditSDK.h/m and ScanditSDKRotatingBarcodePicker.h/m) into the Plugins folder of your project.
    * Right-click on the "Plugins" Group in the Xcode navigation pane and select "Add Files to <name of your project>" 
    * Choose the four files you just copied

* Add frameworks needed by Scandit Barcode Scanner SDK:
    * Click on your project in the navigation pane of Xcode, then select your target and the tab "Build Phases" 
    * Under the entry "Link Binary with Libraries", add the following libraries by clicking the "+" button (most of them will already be listed):
         * AudioToolbox.framework
         * AVFoundation.framework
         * CoreGraphics.framework
         * CoreLocation.framework
         * CoreMedia.framework
         * CoreVideo.framework
         * QuartzCore.framework
         * SystemConfiguration.framework
         * libiconv.dylib
         * libz.dylib 
   
* Register the Plugin with your Cordova App:
    * Open the Cordova.plist file and add an entry to `Plugins` with key `ScanditSDK` and value `ScanditSDK`.


* Start using the Scandit SDK in your html code 
    * Get the app key from your Scandit SDK account
    * Invoke the Scandit SDK scanner by invoking the cordova.exec() function with the following parameters:
	Sample (minimal) `scan` usage: `cordova.exec(function(success), function(cancel), "ScanditSDK", "scan", ["ENTER YOUR APP KEY HERE",{}]);`
    * See `ScanditSDK.h` and the example below for a detailed list of parameters. 
         



How to integrate the Scandit SDK into your own Android Phonegap App
------------------------

* Download and add the Scandit SDK library for Android to your Eclipse Cordova Project:
    * Sign up for a free community license (or one of the enterprise packages) at http://www.scandit.com. 
    * Download the latest Scandit SDK version for Android from your Scandit account. 
    * Unzip the downloaded zip file 
    * Copy the contents of the "libs" folder from the unzipped folder to the `libs` folder of your Phonegap/Cordova project. The `libs` folder includes the shared library libscanditsdk-android-*.so (in a folder called armeabi)
and the scanditsdk-barcodepicker-android-*.jar.
    * Copy the `res/raw` folder to the `res` folder of your Phonegap/Cordova project 

* Add this plugin to your Eclipse Cordova Project:
    * Copy the classes ScanditSDK.java and ScanditSDKActivity.java from the src/android folder of this github repo (in the com.mirasense.scanditsdk.plugin package) into your project preserving the package hierarchy.
    * Refresh your eclipse project for the files to show up in Eclipse

* Add ScanditSDK jar file to your build path:
    * Right-click on the scanditsdk-barcodepicker-android-*.jar file in the libs folder and select "Add to Build Path"
   
* Adjust the import statement in the ScanditSDKActivity class:
    * The ScanditSDKActivity class references the R.java-file of your app which is located in the `gen` directory. Adjust the import statement in the ScanditSDKActivity.java file accordingly.

* Register the Plugin with your Cordova App:
    * Add ScanditSDK Activity to the "application" section of your app's AndroidManifest.xml file

    ```
     <activity android:name="com.mirasense.scanditsdk.plugin.ScanditSDKActivity"/>
    ```
    * Make sure the following permissions are listed in your AndroidManifest.xml file 

    ```
	<uses-permission android:name="android.permission.CAMERA" />
	<uses-permission android:name="android.permission.VIBRATE" />
	<uses-permission android:name="android.permission.INTERNET" />
    ```
    * Add the following line to the res/xml/config.xml resource

    ```
     <plugin name="ScanditSDK" value="com.mirasense.scanditsdk.plugin.ScanditSDK"/>
    ```


* Start using the Scandit SDK in your html code 
    * Get the app key from your Scandit SDK account
    * Invoke the Scandit SDK scanner by invoking the cordova.exec() function with the following parameters:

	Sample (minimal) `scan` usage: 
```
cordova.exec(function(success), function(cancel), "ScanditSDK", "scan", ["YOUR APP KEY HERE",{}]);
```
    * See `ScanditSDK.java` and the example below for a detailed list of parameters.


### Sample HTML + JS

```html
<!DOCTYPE html>
<html>
    <!--
     #
     # Licensed to the Apache Software Foundation (ASF) under one
     # or more contributor license agreements.  See the NOTICE file
     # distributed with this work for additional information
     # regarding copyright ownership.  The ASF licenses this file
     # to you under the Apache License, Version 2.0 (the
     # "License"); you may not use this file except in compliance
     # with the License.  You may obtain a copy of the License at
     #
     # http://www.apache.org/licenses/LICENSE-2.0
     #
     # Unless required by applicable law or agreed to in writing,
     # software distributed under the License is distributed on an
     # "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
     #  KIND, either express or implied.  See the License for the
     # specific language governing permissions and limitations
     # under the License.
     #
     -->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name = "format-detection" content = "telephone=no"/>
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width;" />
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <title>Scandit SDK</title>
    </head>
    <body onload="onBodyLoad()" style="background: url(img/ScanditSDKDemo-Splash.png) no-repeat;background-size: 100%;background-color: #000000">
        <script type="text/javascript" src="cordova-2.2.0.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            function onBodyLoad()
            {
                document.addEventListener("deviceready", onDeviceReady, false);
            }
            
            function success(concatResult) {
                resultArray = concatResult.split("|");
                alert("Scanned " + resultArray[0] + " code: " + resultArray[1]);
            }
            
            function failure(error) {
                alert("Failed: " + error);
            }
            
            function scan() {
                // See ScanditSDK.h for more available options.
                cordova.exec(success, failure, "ScanditSDK", "scan",
                             ["ENTER YOUR APP KEY HERE",
                              {"beep": true,
                              "1DScanning" : true,
                              "2DScanning" : true,
                              "scanningHotspot" : "0.5/0.5",
                              "vibrate" : true,
                              "textForInitialScanScreenState" : "Align code with box",
                              "textForBarcodePresenceDetected" : "Align code and hold still",
                              "textForBarcodeDecodingInProgress" : "Decoding",
                              "searchBarActionButtonCaption" : "Go",
                              "searchBarCancelButtonCaption" : "Cancel",
                              "searchBarPlaceholderText" : "Scan barcode or enter it here",
                              "toolBarButtonCaption" : "Cancel",
                              "minSearchBarBarcodeLength" : 8,
                              "maxSearchBarBarcodeLength" : 15}]);
                
            }
            
            app.initialize();
            </script>
        
        <div align="center" valign="center">
            <input type="button" value="scan" onclick="scan()" style="margin-top: 230px; width: 100px; height: 30px; font-size: 1em"/>
        </div>
    </body>
</html>

```

License
-------
* This plug-in is released under the Apache 2.0 license: http://www.apache.org/licenses/LICENSE-2.0

Notes
-----
* Generic Phone Gap plug-in installation instructions are available at http://wiki.phonegap.com/w/page/43708792/How%20to%20Install%20a%20PhoneGap%20Plugin%20for%20iOS.

Questions? Contact `info@scandit.com`.