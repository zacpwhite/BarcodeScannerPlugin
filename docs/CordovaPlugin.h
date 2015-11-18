
/**
 * Scandit phonegap/cordova plugin that acquires camera frames, shows scan user 
 * interface and decodes barcodes in the camera frames.
 * 
 * Copyright Mirasense AG
 */


@class CordovaPlugin;

/**
 * @brief  phonegap/cordova plugin that acquires camera frames, shows scan user
 * interface and decodes barcodes in the camera frames.
 * 
 * @ingroup scanditsdk-cordova-api
 * 
 * Example (minimal) usage:
 *
 * Set up the Scandit SDK in your javascript code by providing two callback functions and a call to cordova.exec.
 * 
 * The parameter listing below shows all the customization options of the Scandit SDK. They are listed in the 
 * dictionary that follows the app key (see example below). All parameters are optional.
 *
 * @code
 
  function success(resultArray) {
  	alert("Scanned " + resultArray[0] + " code: " + resultArray[1]);
  }
  
  function failure(error) {
       alert("Failed: " + error);
  }
    
  function scan() { 
  	cordova.exec(success, failure, "ScanditSDK", "scan",
                 ["ENTER YOUR APP KEY HERE",
                  {"beep": true,
                   "ean13" : true,
                   "qr" : false}]);
  }
 
 @endcode
 *
 * @since 1.0.0
 *
 * \nosubgrouping
 * Copyright Scandit AG
 */
@interface CordovaPlugin  {
    
    
}

/**
 * @brief Configures and starts the scanner.
 *
 * You invoke the plugin's scan function through the cordova.exec function the following way:
 *  
 * @code
    cordova.exec(success, failure, "ScanditSDK", "scan",
            ["ENTER YOUR APP KEY HERE",
             {"beep": true,
              "ean13" : true,
              "qr" : false}]);
 * @endcode
 * 
 * Parameters of the exec function to invoke the plugin's scan function
 *
 * @param success function to be called when barcode is decoded (or user enters a string in the search bar). The function is called with an array containing two strings. The first string is the content of the barcode, the second string is the symbology of the barcode. The symbology is one of the following strings: "EAN8", "EAN13", "UPC12", "UPCE", "CODE128", "GS1-128", "CODE39", "CODE93", "ITF", "MSI", "CODABAR", "GS1-DATABAR", "GS1-DATABAR-EXPANDED", "QR", "GS1-QR", "DATAMATRIX", "GS1-DATAMATRIX", "PDF417", "TWO-DIGIT-ADD-ON", "FIVE-DIGIT-ADD-ON", "AZTEC".
 * @param failure function to be called when user cancels 
 * @param plugin the plugin name: "ScanditSDK"
 * @param pluginMethod the method name: "scan"
 * @param parameters An array of parameters. The first object has to be the Scandit app key whic is available from your Scandit Account. The second object is an optional dictionary which can contain any of the parameters described below.
 *
 * The following parameters are optional and are specified as part of a json dictionary as shown in the example above.
 * 
 * Camera Configuration
 * 
 * @param preferFrontCamera boolean to use the front camera when a device has two cameras (default is false).
 *
 * Orientation Configuration
 *
 * @param orientations *string* for which orientations are allowed for the iOS scanner (under Android the orientations have to be set in the Manifest where the ScanditSDKActivity is defined). This only works if the scanner is shown in full screen mode
 * and does not work if margins are set. Legal values: portrait, portraitUpsideDown, landscapeLeft,
 * landscapeRight. Example: "landscapeRight,landscapeLeft". Default is the same as set in the app settings.
 *
 * Scanner Behavior and Presentation
 *
 * @param continuousMode *boolean* to enable continous mode. If a barcode is scanned, the scanner is not dismissed and the user is able to continue scanning until he presses "Cancel" or the plugins cancel function is called. Default is false.
 *
 * @param portraitMargins *string* to set left/top/right/bottom margins (in resolution independent pixels) for the scanner in portrait orientation. Settings margins will start the scanner in a subview on top of Cordova's webview and not in its own view controller. Use this parameter to make the scanner smaller than fullscreen and show your own content along with the scanner. Default is "0/0/0/0" (fullscreen).
 *
 * @param landscapeMargins *string* to set left/top/right/bottom margins (in resolution independent pixels) for the scanner in landscape orientation. Settings margins will start the scanner in a subview on top of Cordova's webview and not in its own view controller. Use this parameter to make the scanner smaller than fullscreen and show your own content along with the scanner. Default is "0/0/0/0" (fullscreen).
 *
 * @param paused *boolean* to start the scanner in a paused state instead of already scanning. Default is false.
 *
 * Symbology Selection
 * 
 * @param 1DScanning *boolean* to enable all 1D symbologies are enabled. **Deprecated - enable symbologies individually instead.**
 * @param 2DScanning *boolean* to enable all 2D symbologies are enabled. **Deprecated - enable symbologies individually instead.**
 * @param ean13AndUpc12 *boolean* to enable/disable EAN13 and UPC12 decoding. Default is true.
 * @param ean8 *boolean* to enable/disable EAN8 decoding. Default is true.
 * @param upce *boolean* to enable/disable UPCE decoding. Default is true.
 * @param code39 *boolean* to enable/disable CODE39 decoding. Default is true.
 * @param code128 *boolean* to enable/disable CODE128 decoding. Default is true.
 * @param itf *boolean* to enable/disable Interleaved-Two-of-Five (ITF) decoding. Default is true.
 * @param gs1DataBar *boolean* to enable/disable GS1 DataBar decoding. Default is false.
 * @param gs1DataBarExpanded *boolean* to enable/disable GS1 DataBar Expanded decoding. Default is false.
 * @param codabar *boolean* to enable/disable Codabar decoding. Default is false.
 * @param qr *boolean* to enable/disable QR decoding. Default is true.
 * @param dataMatrix *boolean* to enable/disable Datamatrix decoding. Default is true.
 * @param pdf417 *boolean* to enable/disable PDF417 decoding. Default is true.
 * @param aztec *boolean* to enable/disable Aztec decoding. Default is false.
 * @param msiPlessey *boolean* to enable/disable MSIPlessey decoding. Default is false.
 * @param msiPlesseyChecksumType *string* enum to set the type of checksum that is expected of the MSI Plessey codes.
 Legal values are: "none", "mod10", "mod11", "mod1010", "mod1110". Default is "mod10".
 *
 * Barcode Decoder Configuration
 *
 * @param inverseRecognition *boolean* to enable/disable white on black Data Matrix and QR code decoding. Default is false.
 * @param microDataMatrix *boolean* to enable/disable tiny Data Matrix decoder. Default is false.
 * @param force2d *boolean* to force running 2D decoder even when detector does not detect 2D code presence. Default is false.
 * @param scanningHotSpot *string* of the location in the image where the barcodes are decoded with the highest priority. The hotspot coordinates are passed in the format "x/y" where x and y are floats between 0 and 1 where "0/0" corresponds to the top left corner and "1/1" to the bottom right corner. Default is "0.5/0.5".
 * @param scanningHotSpotHeight *float* height of the area where barcodes are decoded in the camera image. The area is centered around the location set through the "scanningHotSpot" parameter. The height is relative to the screen and has to be between 0.0 and 0.5. If no hot spot height is set, barcodes everywhere in the image are decoded.
 * @param codeDuplicateFilter *integer* duration of the duplicate filter in milliseconds. When set to a value larger than zero, barcodes with the same symbology and data are filtered out if they are decoded less than the given milliseconds apart. Set this value to zero if you do not want to filter duplicates. When set to -1 barcodes are filtered as duplicates if they match an already decoded barcode in the session (A session ends with a call to cancel or stop or a successful scan in non-continuous mode). (see native @ref SBSScanSettings:codeDuplicateFilter)
 *
 * Sound Configuration
 *
 * @param beep *boolean* to enable/disable the sound played when a code was recognized. Default is true.
 * @param vibrate *boolean* to enable/disable the vibration when a code was recognized. Default is true.
 * 
 * Torch Configuration
 *
 * @param torch *boolean* to enable/disable the torch toggle button for all devices that support a torch. Default is true.
 * @param torchButtonPositionAndSize *string* position at which the button to enable the torch is drawn. The position is passed in the format "0.05/0.05/40/40" (x/y/width/height). The X and Y coordinates are relative to the screen size, which means they have to be between 0 and 1.
 * @param torchButtonMarginsAndSize *string* position at which the button to enable the torch is drawn. The position is passed in the format "15/15/40/40" (leftMargin/topMargin/width/height). All values are in resolution independent pixels.
 *
 * Camera Switch Configuration 
 * 
 * @param cameraSwitchVisibility *string* enum to set when the camera switch button is visible for devices that have more than one camera. Values are: "never", "tablet", "always". Default is "never".
 * @param cameraSwitchButtonPositionAndSize *string* position at which the button to switch the camera is drawn. The position is passed in the format "0.05/0.05/40/40" (inverseX/y/width/height). The inverse X (distance from right side instead of left) and Y coordinates are relative to the screen size, which means they have to be between 0 and 1.
 * @param cameraSwitchButtonMarginsAndSize *string* position at which the button to switch the camera is drawn. The position is passed in the format "15/15/40/40" (leftMargin/topMargin/width/height). All values are in resolution independent pixels.
 * 
 * Searchbar Configuration
 * 
 * @param searchBar *boolean* to show or hide the search bar at the top of the screen. Default is false.
 * @param searchBarActionButtonCaption *string* to set caption of the "Go" button.
 * @param searchBarCancelButtonCaption *string* to set caption of the "Cancel" button.
 * @param searchBarPlaceholderText *string* placeholder text:, e.g. "Scan barcode or enter it here".
 * @param minSearchBarBarcodeLength *integer* minimum size a barcode in the search bar has to have to be valid.
 * @param maxSearchBarBarcodeLength *integer* maximum size a barcode in the search bar can have to be valid.
 * 
 * Toolbar Configuration
 * 
 * @param toolBarButtonCaption *string* to set the caption of the tool bar's "Cancel" button.
 * 
 * Viewfinder Configuration
 * 
 * @param guiStyle *string* to set the style of the viewfinder. Can be one of "default" or "laser".
 * @param viewfinderSize *string* to set the size of the viewfinder. The size is passed in the format "0.9/0.4/0.6/0.4" (width/height/landscapeWidth/landscapeHeight) where all lengths are relative to the screen size.
 * @param viewfinderColor *string* to set the color of the viewfinder. Default is "FFFFFF".
 * @param viewfinderDecodedColor *string* to set the color of the viewfinder when the code has been recognized. Default is "3AC1CD".
 *
 * Analytics Configuration
 *
 * @param deviceName *string* to set a device name that identifies this device when looking at analytics tools. Sends a request to the server to set this as soon as a connection is available.
 */
- (void)scan;


/**
 * @brief Cancels the scanning.
 *
 * You invoke the plugin's cancel function through the cordova.exec function the following way:
 *
 * @code
    cordova.exec(success, failure, "ScanditSDK", "cancel", []);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's cancel function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "cancel"
 * @param parameters An empty array.
 */
- (void)cancel;


/**
 * @brief Pauses the scanning while the video feed continues to run.
 *
 * You invoke the plugin's pause function through the cordova.exec function the following way:
 *
 * @code
    cordova.exec(success, failure, "ScanditSDK", "pause", []);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's pause function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "pause"
 * @param parameters An empty array.
 */
- (void)pause;


/**
 * @brief Resumes the scanning after pause was called.
 *
 * You invoke the plugin's cancel function through the cordova.exec function the following way:
 *
 * @code
    cordova.exec(success, failure, "ScanditSDK", "resume", []);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's Resume function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "resume"
 * @param parameters An empty array
 */
void resume(success, failure, parameters);


/**
 * @brief Stops the scanning and also freezes the video feed.
 *
 * You invoke the plugin's stop function through the cordova.exec function the following way:
 *
 * @code
 cordova.exec(success, failure, "ScanditSDK", "stop", []);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's cancel function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "stop"
 * @param parameters An empty array.
 */
- (void)stop;


/**
 * @brief Restarts the scanning after stop or pause were called.
 *
 * You invoke the plugin's start function through the cordova.exec function the following way:
 *
 * @code
 cordova.exec(success, failure, "ScanditSDK", "start", []);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's start function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "start"
 * @param parameters An empty array.
 */
-(void)start;


/**
 * @brief Configures and starts the scanner.
 *
 * You invoke the plugin's scan function through the cordova.exec function the following way:
 *
 * @code
    cordova.exec(null, null, "ScanditSDK", "resize", [{"beep": false}]);
 * @endcode
 *
 * Parameters of the exec function to invoke the plugin's scan function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "resize"
 * @param parameters An array of parameters. The first and only object is an optional dictionary which can contain any of the parameters described below.
 *
 * The following parameters are optional and are specified as part of a json dictionary as shown in the example above.
 *
 * Camera Configuration
 *
 * @param preferFrontCamera boolean to use the front camera when a device has two cameras (default is false).
 *
 * Orientation Configuration
 *
 * @param orientations *string* for which orientations are allowed for the iOS scanner (under Android the orientations have to be set in the Manifest where the ScanditSDKActivity is defined). This only works if the scanner is shown in full screen mode
 * and does not work if margins are set. Legal values: portrait, portraitUpsideDown, landscapeLeft,
 * landscapeRight. Example: "landscapeRight,landscapeLeft". Default is the same as set in the app settings.
 *
 * Scanner Behavior and Presentation
 *
 * @param animationDuration *float* to set the animation duration for the change in margins. Default is 0.0.
 *
 * @param portraitMargins *string* to set left/top/right/bottom margins (in resolution independent pixels) for the scanner in portrait orientation. Settings margins will start the scanner in a subview on top of Cordova's webview and not in its own view controller. Use this parameter to make the scanner smaller than fullscreen and show your own content along with the scanner. Default is "0/0/0/0" (fullscreen).
 *
 * @param landscapeMargins *string* to set left/top/right/bottom margins (in resolution independent pixels) for the scanner in landscape orientation. Settings margins will start the scanner in a subview on top of Cordova's webview and not in its own view controller. Use this parameter to make the scanner smaller than fullscreen and show your own content along with the scanner. Default is "0/0/0/0" (fullscreen).
 *
 * Barcode Decoder Configuration
 *
 * @param scanningHotSpot *string* of the location in the image where the barcodes are decoded with the highest priority. The hotspot coordinates are passed in the format "x/y" where x and y are floats between 0 and 1 where "0/0" corresponds to the top left corner and "1/1" to the bottom right corner. Default is "0.5/0.5".
 * @param scanningHotSpotHeight *float* height of the area where barcodes are decoded in the camera image. The area is centered around the location set through the "scanningHotSpot" parameter. The height is relative to the screen and has to be between 0.0 and 0.5. If no hot spot height is set, barcodes everywhere in the image are decoded.
 *
 * Sound Configuration
 *
 * @param beep *boolean* to enable/disable the sound played when a code was recognized. Default is true.
 * @param vibrate *boolean* to enable/disable the vibration when a code was recognized. Default is true.
 *
 * Torch Configuration
 *
 * @param torch *boolean* to enable/disable the torch toggle button for all devices that support a torch. Default is true.
 * @param torchButtonPositionAndSize *string* position at which the button to enable the torch is drawn. The position is passed in the format "0.05/0.05/40/40" (x/y/width/height). The X and Y coordinates are relative to the screen size, which means they have to be between 0 and 1.
 *
 * Camera Switch Configuration
 *
 * @param cameraSwitchVisibility *string* enum to set when the camera switch button is visible for devices that have more than one camera. Values are: "never", "tablet", "always". Default is "never".
 * @param cameraSwitchButtonPositionAndSize *string* position at which the button to switch the camera is drawn. The position is passed in the format "0.05/0.05/40/40" (inverseX/y/width/height). The inverse X (distance from right side instead of left) and Y coordinates are relative to the screen size, which means they have to be between 0 and 1.
 *
 * Searchbar Configuration
 *
 * @param searchBar *boolean* to show or hide the search bar at the top of the screen. Default is false.
 * @param searchBarActionButtonCaption *string* to set caption of the "Go" button.
 * @param searchBarCancelButtonCaption *string* to set caption of the "Cancel" button.
 * @param searchBarPlaceholderText *string* placeholder text:, e.g. "Scan barcode or enter it here".
 * @param minSearchBarBarcodeLength *integer* minimum size a barcode in the search bar has to have to be valid.
 * @param maxSearchBarBarcodeLength *integer* maximum size a barcode in the search bar can have to be valid.
 *
 * Viewfinder Configuration
 *
 * @param viewfinderSize *string* to set the size of the viewfinder. The size is passed in the format "0.9/0.4/0.6/0.4" (width/height/landscapeWidth/landscapeHeight) where all lengths are relative to the screen size.
 * @param viewfinderColor *string* to set the color of the viewfinder. Default is "FFFFFF".
 * @param viewfinderDecodedColor *string* to set the color of the viewfinder when the code has been recognized. Default is "3AC1CD".
 */
- (void)resize;

/**
 * @brief Turns the torch on or off once the scanner is running.
 *
 * You invoke the plugin's torch function through the cordova.exec function the following way:
 *
 * @code
 cordova.exec(null, null, "ScanditSDK", "torch", [true]);
 
 @endcode
 *
 * Parameters of the exec function to invoke the plugin's torch function
 *
 * @param success There is no failure callback: null
 * @param failure There is no failure callback: null
 * @param plugin The plugin name: "ScanditSDK"
 * @param pluginMethod The method name: "torch"
 * @param parameters An array containing one boolean to say whether the torch should be on or off.
 */
- (void)torch;

@end

