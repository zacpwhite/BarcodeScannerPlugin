BarcodeScannerPlugin
====================

Cross platform Phonegap/Cordova Plugin of the Scandit Barcode Scanner SDK for iOS and Android

Follow the detailed instructions below to add a high-performance barcode scanner to your app in 5 min using [Plugman](https://github.com/imhotep/plugman).

If you don't have a Phonegap app yet, but want to try out our Phonegap Plugins anyway, [follow the instructions on phonegap.com](http://docs.phonegap.com/) to generate a sample app. 


Scandit SDK Plugin Integration with Plugman 
------------------------

The easiest way to install the Scandit plugin into your Phonegap/Cordova project is to use [Plugman](https://github.com/imhotep/plugman). 

1. Sign up and download the Scandit SDK Cordova Plugins for iOS and Android from your Scandit SDK account.
2. Install Android and iOS Scandit SDK Plugin using [Plugman](https://github.com/imhotep/plugman)

        plugman --platform android --project . --plugin <path to unzipped ScanditSDK Plugin for Android> 
        plugman --platform ios --project . --plugin <path to unzipped ScanditSDK Plugin for iOS> 

   There is a [bug](https://issues.apache.org/jira/browse/CB-2718) in [Plugman](https://github.com/imhotep/plugman) that prevents .a files (static libraries) to be installed properly under iOS. To add the `libscanditsdk-iphone-<version>.a` file under iOS, you need click on your project in the navigation pane of Xcode, select your target and the tab "Build Phases". Under the entry "Link Binary with Libraries", add the `libscanditsdk-iphone-<version>.a` library by clicking the "+" button and select it from the file system by clicking "add other".
 
3. Start using the Scandit SDK in your html code 
    * Get the app key from your Scandit SDK account
    * Invoke the Scandit SDK scanner by invoking the cordova.exec() function with the following parameters:

	`cordova.exec(function(success), function(cancel), "ScanditSDK", "scan", ["ENTER YOUR APP KEY HERE",{}]);`

    * See full example and API below for a detailed list of options. 

To install [Plugman](https://github.com/imhotep/plugman):

         git clone https://github.com/imhotep/plugman.git
         cd plugman
         npm install -g


Manual Scandit SDK Plugin Integration for iOS 
------------------------

* Download and add the Scandit SDK for iOS library to your Xcode Cordova Project:
    * Sign up for a free community license (or one of the enterprise packages) at http://www.scandit.com. 
    * Download the Scandit SDK Cordova Plugin for iOS version from your Scandit account and unzip it. 
    * Open your project in Xcode, right-click on the `Plugins` group in the navigation pane and select "Add Files to <name of your project>" 
    * Choose the files folders below from the zip you downloaded above (make sure you select the options `create group for added folders` and the `copy items to destination group's folder`):
         * ScanditSDK.h
         * ScanditSDK.mm
         * ScanditSDKBarcodePicker.h
         * ScanditSDKBarcodePicker.m
         * ScanditSDK folder (which includes the libscanditsdk-iphone-<version>.a static lib)

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
         * libc++.dylib
   
* Register the Plugin with your Cordova App:
    * Open the Cordova.plist file and add an entry to `Plugins` with key `ScanditSDK` and value `ScanditSDK`.

* Start using the Scandit SDK in your html code 
    * Get the app key from your Scandit SDK account
    * Invoke the Scandit SDK scanner by invoking the cordova.exec() function with the following parameters:
	Sample (minimal) `scan` usage: `cordova.exec(function(success), function(cancel), "ScanditSDK", "scan", ["ENTER YOUR APP KEY HERE",{}]);`
    * See full example and API below for a detailed list of options.  
         

Manual Scandit SDK Plugin Integration for Android
------------------------

* Download and add the Scandit SDK library for Android to your Eclipse Cordova Project:
    * Sign up for a free community license (or one of the enterprise packages) at http://www.scandit.com. 
    * Download the latest Scandit SDK Phonegap/Cordova for Android from your Scandit account. 
    * Unzip the downloaded zip file 
    * Copy the contents of the "libs" folder from the unzipped folder to the `libs` folder of your Phonegap/Cordova project. The `libs` folder includes the shared library libscanditsdk-android-*.so (in a folder called armeabi)
and the scanditsdk-barcodepicker-android-*.jar.
    * Copy the `res/raw` folder to the `res` folder of your Phonegap/Cordova project 
    * Copy the classes ScanditSDK.java and ScanditSDKActivity.java from the src/android folder (in the com.mirasense.scanditsdk.plugin package) into your project preserving the package hierarchy.
    * Refresh your eclipse project for the files to show up in Eclipse

* Add ScanditSDK jar file to your build path:
    * Right-click on the scanditsdk-barcodepicker-android-*.jar file in the libs folder and select "Add to Build Path"
   
* Register the Plugin with your Cordova App and set the permissions correctly:
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
    * See full example and API below for a detailed list of options. 


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
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            function onBodyLoad()
            {
                document.addEventListener("deviceready", onDeviceReady, false);
            }
            
	    function success(resultArray) {

		alert("Scanned " + resultArray[0] + " code: " + resultArray[1]);

            	// NOTE: Scandit SDK Phonegap Plugin Versions 1.* for iOS report
            	// the scanning result as a concatenated string.
            	// Starting with version 2.0.0, the Scandit SDK Phonegap
            	// Plugin for iOS reports the result as an array
            	// identical to the way the Scandit SDK plugin for Android reports results.
            
            	// If you are running the Scandit SDK Phonegap Plugin Version 1.* for iOS,
            	// use the following approach to generate a result array from the string result returned:
            	// resultArray = result.split("|");
            }
            
            function failure(error) {
                alert("Failed: " + error);
            }
            
            function scan() {
                // See below for all available options. 
                cordova.exec(success, failure, "ScanditSDK", "scan",
                             ["ENTER YOUR APP KEY HERE",
                              {"beep": true,
                              "1DScanning" : true,
                              "2DScanning" : true}]);
            }
            
            app.initialize();
            </script>
        
        <div align="center" valign="center">
            <input type="button" value="scan" onclick="scan()" style="margin-top: 230px; width: 100px; height: 30px; font-size: 1em"/>
        </div>
    </body>
</html>

```


Changelog
------------------------

Scandit SDK Phonegap Plugin 2.0.1 for iOS only - June 17th 2013**

 * upgraded to Scandit SDK 3.0.3 for iOS which is a new bug fix release (see release notes of native iOS version for details)

**Scandit SDK Phonegap Plugin 2.0.0 for iOS only - May 11th 2013**

 * upgraded to new Scandit SDK 3.0.1 for iOS which comprises various new features: full screen scanning, 
   improved autofocus management, better scan performance and robustness, new cleaner scan screen interface 
   with the option to add a button to switch cameras and new symbologies (PDF417 beta and MSI-Plessey).

 * IMPORTANT: updated Scandit SDK Phonegap Plugin API to reflect updates in Scandit SDK 3.0.1 for iOS. 
   This includes a number of new API options (see below), a number of options have also disappeared. 

 * harmonized return results of Android and iPhone Plugin. In previous versions, 
   the iOS Plugin would return a string, while the Android Plugin would return an array. 
   Starting with Scandit SDK Phonegap Plugin for iOS 2.0.0, the iOS Plugin will also return an array. 



**Scandit SDK Phonegap Plugin 1.1.0 for Android & iOS - April 2nd 2013**

 * upgraded to native Scandit SDK 2.2.7 for iOS and 3.3.1 for Android
 
 * includes support PLUGMAN

 * Fixed a bug that would freeze and stop the modal view from closing.

 * Scandit SDK Phonegap Plugin for Android now also supports barcode scanning in landscape mode.

 * Minor changes to ScanditSDKActivity.java 




API for Scandit SDK Phonegap Plugin iOS and Android  1.* 
------------------------

 * searchBar: true
 
Shows or hides the search bar at the top of the screen.
 
 * 1DScanning: true
 
Enables or disables the recognition of 1D codes.
 
 * 2DScanning: true

Enables or disables the recognition of 2D codes.
 
 * ean13AndUpc12: true

Enables or disables the recognition of EAN13 and UPC12/UPCA codes.
 
 * ean8: true

Enables or disables the recognition of EAN8 codes.
 
 * upce: true

Enables or disables the recognition of UPCE codes.
 
 * code39: true

Enables or disables the recognition of CODE39 codes.
Note: Not all Scandit SDK versions support Code 39 scanning.
 
 * code128: true

Enables or disables the recognition of CODE128 codes.
Note: Not all Scandit SDK versions support Code 128 scanning.
 
 * itf: true

Enables or disables the recognition of ITF codes.
Note: Not all Scandit SDK versions support ITF scanning.
 
 * qr: false

Enables or disables the recognition of QR codes.
 
 * dataMatrix: false

Enables or disables the recognition of Data Matrix codes.
Note: Not all Scandit SDK versions support Data Matrix scanning.
 
 * inverseRecognition: false

Enables the detection of white on black codes. This option currently
only works on Data Matrix codes.
 
 * microDataMatrix: false
 
Enables special settings to allow the recognition of very small Data
Matrix codes. If this is not specifically needed, do not enable it as it
uses considerable processing power. This setting automatically forces
2d recognition on every frame. This option only works on devices with
Android 2.2 or higher, it does not cause issues with lower versions but
simply doesn't work.
 
 * force2d: false
 
Forces the engine to always run a 2d recognition, ignoring whether a 2d
code was detected in the current frame.
 
 * scanningHotSpot: "0.5/0.5" (x/y)

Changes the location of the spot where the recognition actively scans for
barcodes. X and y can be between 0 and 1, where 0/0 is the top left corner
and 1/1 the bottom right corner.
 
 * scanningHotSpotHeight: 0.25

Changes the height of the spot where the recognition actively scans for
barcodes. The height of the hot spot is given relative to the height of
the screen and has to be between 0.0 and 0.5.
Be aware that if the hot spot height is very large, the engine is forced
to decrease the quality of the recognition to keep the speed at an
acceptable level.
 
 * ignorePreviewAspectRatio: false

Normally the picker adjusts to the aspect ratio of the preview image. If
Note: If the aspect ratio is not kept, the camera feed may be
stretched and no longer be a proper representation of what is recorded.
 
 * beep: true

Enables or disables the sound played when a code was recognized.
 
 * vibrate: true

Enables or disables the vibration when a code was recognized.
 
 * uiFont: "Helvetica"

Sets the font of all text displayed in the UI (must be known by iOS).
 
 * textForMostLikelyBarcodeUIElement: "Tap to use"

Sets the text that will be displayed alongside the lucky shot to tell the user what to do, to
use the displayed barcode.
 
 * textForInitialScanScreenState: "Align code with box"

Sets the text that will be displayed above the viewfinder to tell the user to align it with the
barcode that should be recognized.
 
 * textForBarcodePresenceDetected: "Align code and hold still"

Sets the text that will be displayed above the viewfinder to tell the user to align it with the
barcode and hold still because a potential code seems to be on the screen.
 
 * textForBarcodeDecodingInProgress: "Decoding ..."

Sets the text that will be displayed above the viewfinder to tell the user to hold still because
a barcode is aligned with the box and the recognition is trying to recognize it.
 
 * searchBarActionButtonCaption: "Go"

Sets the caption of the manual entry at the top when a barcode of valid length has been entered.
 
 * searchBarCancelButtonCaption: "Cancel"

Sets the caption of the manual entry at the top when no barcode of valid length has been entered.
 
 * searchBarPlaceholderText: "Scan barcode or enter it here"

Sets the text shown in the manual entry field when nothing has been entered yet.
 
 * toolBarButtonCaption: "Cancel"

Sets the caption of the toolbar button.
 
 * viewfinderColor: "FFFFFF"

Sets the color of the static viewfinder and while tracking before the code has been recognized.
 
 * viewfinderDecodedColor: "00FF00"

Sets the color of the viewfinder when the code has been recognized.
 
 * minSearchBarBarcodeLength: 8

Sets the minimum size a barcode in the manual entry field has to have to possibly be valid.
 
 * maxSearchBarBarcodeLength: 100

Sets the maximum size a barcode in the manual entry field can have to possibly be valid.
 


API for Scandit SDK Phonegap Plugin iOS 2.* and higher
------------------------

The available options that can be passed to scan function are listed below:

 * preferFrontCamera: false

Whether showing the front camera should be prefered over the back camera (for devices without a
front camera the back camera is shown).
 
 * searchBar: true
  
Shows or hides the search bar at the top of the screen.

 * 1DScanning: true
 
Enables or disables the recognition of 1D codes.
 
 * 2DScanning: true
 
Enables or disables the recognition of 2D codes.
 
 * ean13AndUpc12: true

Enables or disables the recognition of EAN13 and UPC12/UPCA codes.
 
 * ean8: true

Enables or disables the recognition of EAN8 codes.
 
 * upce: true

Enables or disables the recognition of UPCE codes.
 
 * code39: true

Enables or disables the recognition of CODE39 codes.
Note: Not all Scandit SDK editions support Code 39 scanning.
 
 * code128: true

Enables or disables the recognition of CODE128 codes.
Note: Not all Scandit SDK editions support Code 128 scanning.
 
 * itf: true

Enables or disables the recognition of ITF codes.
Note: Not all Scandit SDK editions support ITF scanning.
 
 * qr: true

Enables or disables the recognition of QR codes.
 
 * dataMatrix: true

Enables or disables the recognition of Data Matrix codes.
Note: Not all Scandit SDK versions support Data Matrix scanning.
 
 * pdf417: true

Enables or disables the recognition of PDF417 codes.
Note: Not all Scandit SDK versions support PDF417 scanning.
 
 * msiPlessey: false

Enables or disables the recognition of MSI Plessey codes.
Note: Not all Scandit SDK versions support MSI Plessey scanning.
 
 * msiPlesseyChecksumType: "mod10"

Sets the type of checksum that is expected of the MSI Plessey codes.
Legal values are: "none", "mod10", "mod11", "mod1010", "mod1110"
 
 * inverseRecognition: false

Enables the detection of white on black codes. This option currently
only works on Data Matrix codes.
 
 * microDataMatrix: false

Enables special settings to allow the recognition of very small Data
Matrix codes. If this is not specifically needed, do not enable it as it
uses considerable processing power. This setting automatically forces
2d recognition on every frame. 

 * restrictActiveScanningArea: false

Reduces the area in which barcodes are detected and decoded to an
area defined by setScanningHotSpotHeight and setScanningHotSpotToX andY.
If this method is set to disabled, barcodes in the full camera image
are detected and decoded.
 
 * force2d: false

Forces the engine to always run a 2d recognition, ignoring whether a 2d
code was detected in the current frame.
 
 * scanningHotSpot: "0.5/0.5" (x/y)

Changes the location of the spot where the recognition actively scans for
barcodes. X and y can be between 0 and 1, where 0/0 is the top left corner
and 1/1 the bottom right corner.
 
 * scanningHotSpotHeight: 0.25

Changes the height of the spot where the recognition actively scans for
barcodes. The height of the hot spot is given relative to the height of
the screen and has to be between 0.0 and 0.5.
Be aware that if the hot spot height is very large, the engine is forced
to decrease the quality of the recognition to keep the speed at an
acceptable level.

Note: this option only works with restrictActiveScanningArea set to true

 * viewfinderSize: "0.8/0.4/0.6/0.4" (width/height/landscapeWidth/landscapeHeight)

Sets the size of the viewfinder relative to the size of the screen size.
Changing this value does not(!) affect the area in which barcodes are successfully recognized.
It only changes the size of the box drawn onto the scan screen.
 
 * ignorePreviewAspectRatio: false

Normally the picker adjusts to the aspect ratio of the preview image. If
this is called, it will no longer do this.
Note: If the aspect ratio is not kept, the camera feed may be
stretched and no longer be a proper representation of what is recorded.
 
 * beep: true
 
Enables or disables the sound played when a code was recognized.
 
 * vibrate: true

Enables or disables the vibration when a code was recognized.
 
 * torch: true

Enables or disables the torch toggle button for all devices that support a torch.
 
 * torchButtonPositionAndSize: "0.05/0.01/67/33" (x/y/width/height)

Sets the position at which the button to enable the torch is drawn. The X and Y coordinates are
relative to the screen size, which means they have to be between 0 and 1.
 
 * cameraSwitchVisibility: "never"

Sets when the camera switch button is visible for all devices that have more than one camera.
Legal values are: "never", "tablet", "always"
 
 * cameraSwitchButtonPositionAndSize: "0.05/0.01/67/33" (x/y/width/height)

Sets the position at which the button to switch the camera is drawn. The X and Y coordinates are
relative to the screen size, which means they have to be between 0 and 1. Be aware that the x
coordinate is calculated from the right side of the screen and not the left like with the torch
button.
 
 * logoOffsets: "0, 0, 0, 0" (xOffset, yOffset, landscapeXOffset, landscapeYOffset)

Sets the x and y offset at which the Scandit logo should be drawn for both portrait and landscape
orientation. Be aware that the Scandit SDK license agreement requires you to show the Scandit 
logo in the scan screen.
 
 * searchBarActionButtonCaption: "Go"

Sets the caption of the manual entry at the top when a barcode of valid length has been entered.
 
 * searchBarCancelButtonCaption: "Cancel"

Sets the caption of the manual entry at the top when no barcode of valid length has been entered.
 
 * searchBarPlaceholderText: "Scan barcode or enter it here"

Sets the text shown in the manual entry field when nothing has been entered yet.
 
 * toolBarButtonCaption: "Cancel"

Sets the caption of the toolbar button.
 
 * viewfinderColor: "FFFFFF"

Sets the color of the static viewfinder and while tracking before the code has been recognized.
Not available in free community edition. 
 
 * viewfinderDecodedColor: "00FF00"

Sets the color of the viewfinder when the code has been recognized.
Not available in free community edition. 

 * minSearchBarBarcodeLength: 8

Sets the minimum size a barcode in the manual entry field has to have to possibly be valid.
 
 * maxSearchBarBarcodeLength: 100

Sets the maximum size a barcode in the manual entry field can have to possibly be valid.







License
-------
* This plug-in is released under the Apache 2.0 license: http://www.apache.org/licenses/LICENSE-2.0

Notes
-----
* Generic Phone Gap plug-in installation instructions are available at http://wiki.phonegap.com/w/page/43708792/How%20to%20Install%20a%20PhoneGap%20Plugin%20for%20iOS.

Questions? Contact `info@scandit.com`.




