

Troubleshooting Cordova/PhoneGap     {#cordova-troubleshooting}
========================


\tableofcontents


# App crashes when the barcode picker is shown {#cordovaappcrash}

An app crash when showing the barcode picker can occur if

* there is a problem with your app key. The Scandit Barcode Scanner will crash when the correct app key is not set. Make sure you copied the app key from your account correctly when you are instantiating the SBSBarcodePicker object. 

* you are using the test edition of the Scandit Barcode Scanner and there is no internet connection. The trial edition requires an internet connection and the picker will shutdown when none is available. 

* there is a problem with our scanner and/or the way it is used in your app. Contact us at support@scandit.com with a description of the problem (if possible with a code snippet or project) including details about your setup (iOS version, iOS device name, info whether our demo app works correctly).


<br/>
# Installing under Windows fails {#windowsinstall}

Windows has a maximum file path length which means that it is not possible to create new folders after a certain depth in the file system has been reached. Since adding a plugin copies files in an already quite deep folder structure an install can fail because the maximum file path length has been reached and the system fails to copy all the files necessary. To avoid this move your project as high up in the file system as possible (to something like C:\\yourProject).


<br/>
# You were unable to find a solution to your problem {#cordovanosolution}

If your specific problem does not have a solution on this page, contact us at support@scandit.com with a description of the problem (if possible with a code snippet or project) including details about your setup (iOS version, iOS device name, info whether our demo app works correctly).


