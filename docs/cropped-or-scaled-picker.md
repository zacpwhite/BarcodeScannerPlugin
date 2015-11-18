
Displaying the %Scandit SDK plugin as a cropped and/or scaled subview {#cordova-cropped-or-scaled-picker}
===================================

The plugin allows you to display it as a cropped and/or scaled subview such that parts of your UI is still visible and can be interacted with while scanning. You can accomplish this by setting the portraitMargins and landscapeMargins setting when calling the scan function.

~~~~~~~~~~~~~~~~{.java}
cordova.exec(success, failure, "ScanditSDK", "scan",
             ["ENTER YOUR APP KEY HERE", {"portraitMargins" : "0/0/0/200", "landscapeMargins" : "0/0/200/0"}]);
~~~~~~~~~~~~~~~~

This code would show the scanner with a 200 point bottom margin in portrait orientation and a 200 point right margin in landscape orientation. It is possible to adjust these margins while the scanner is running by using the resize function.

~~~~~~~~~~~~~~~~{.java}
cordova.exec(null, null, "ScanditSDK", "resize",
             ["{"portraitMargins" : "0/0/0/100", "landscapeMargins" : "0/0/100/0", "animationDuration" : 0.5}]);
~~~~~~~~~~~~~~~~

This code would reduce the margins to 100 points and animate that change over 0.5 seconds.


## Starting and stopping while the scanner is visible

When you are adding the plugin as a subview there will not be any default way of closing the scanner again which means you will have to implement it in some way. For this there is a cancel function available which closes the scanner. It is used the following way:

~~~~~~~~~~~~~~~~{.java}
cordova.exec(null, null, "ScanditSDK", "cancel");
~~~~~~~~~~~~~~~~

Additionally you are also able to stop or pause the scanner but still keep it visible. For pausing the scanner but keeping the video feed running you use the pause function and restart with resume:

~~~~~~~~~~~~~~~~{.java}
cordova.exec(null, null, "ScanditSDK", "pause");
cordova.exec(null, null, "ScanditSDK", "resume");
~~~~~~~~~~~~~~~~

If you would like the camera to stop entirely you can use the stop function and restart it with start:

~~~~~~~~~~~~~~~~{.java}
cordova.exec(null, null, "ScanditSDK", "stop");
cordova.exec(null, null, "ScanditSDK", "start");
~~~~~~~~~~~~~~~~