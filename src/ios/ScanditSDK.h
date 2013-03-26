
//
//  Copyright 2010 Mirasense AG
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

#import "Cordova/CDVPlugin.h"
#import "ScanditSDKBarcodePicker.h"
#import "ScanditSDKOverlayController.h"

@interface ScanditSDK : CDVPlugin <ScanditSDKOverlayControllerDelegate> {
    NSString *callbackId;
    BOOL wasStatusBarHidden;
	
	BOOL startAnimationDone;
	NSDictionary *bufferedResult;
}

@property (nonatomic, copy) NSString *callbackId;
@property (readwrite, assign) BOOL hasPendingOperation;
@property (nonatomic, retain) NSDictionary *bufferedResult;

/**
 * Start scanning. The available options to pass this function are as follows:
 *
 * exampleStringForOption: defaultValue
 * Short explanation of option.
 *
 * searchBar: true
 * Shows or hides the search bar at the top of the screen.
 *
 * 1DScanning: true
 * Enables or disables the recognition of 1D codes.
 *
 * 2DScanning: true
 * Enables or disables the recognition of 2D codes.
 *
 * ean13AndUpc12: true
 * Enables or disables the recognition of EAN13 and UPC12/UPCA codes.
 *
 * ean8: true
 * Enables or disables the recognition of EAN8 codes.
 *
 * upce: true
 * Enables or disables the recognition of UPCE codes.
 *
 * code39: true
 * Enables or disables the recognition of CODE39 codes.
 * Note: Not all Scandit SDK versions support Code 39 scanning.
 *
 * code128: true
 * Enables or disables the recognition of CODE128 codes.
 * Note: Not all Scandit SDK versions support Code 128 scanning.
 *
 * itf: true
 * Enables or disables the recognition of ITF codes.
 * Note: Not all Scandit SDK versions support ITF scanning.
 *
 * qr: false
 * Enables or disables the recognition of QR codes.
 *
 * dataMatrix: false
 * Enables or disables the recognition of Data Matrix codes.
 * Note: Not all Scandit SDK versions support Data Matrix scanning.
 *
 * inverseRecognition: false
 * Enables the detection of white on black codes. This option currently
 * only works on Data Matrix codes.
 *
 * microDataMatrix: false
 * Enables special settings to allow the recognition of very small Data
 * Matrix codes. If this is not specifically needed, do not enable it as it
 * uses considerable processing power. This setting automatically forces
 * 2d recognition on every frame. This option only works on devices with
 * Android 2.2 or higher, it does not cause issues with lower versions but
 * simply doesn't work.
 *
 * force2d: false
 * Forces the engine to always run a 2d recognition, ignoring whether a 2d
 * code was detected in the current frame.
 *
 * scanningHotSpot: "0.5/0.5" (x/y)
 * Changes the location of the spot where the recognition actively scans for
 * barcodes. X and y can be between 0 and 1, where 0/0 is the top left corner
 * and 1/1 the bottom right corner.
 *
 * scanningHotSpotHeight: 0.25
 * Changes the height of the spot where the recognition actively scans for
 * barcodes. The height of the hot spot is given relative to the height of
 * the screen and has to be between 0.0 and 0.5.
 * Be aware that if the hot spot height is very large, the engine is forced
 * to decrease the quality of the recognition to keep the speed at an
 * acceptable level.
 *
 * ignorePreviewAspectRatio: false
 * Normally the picker adjusts to the aspect ratio of the preview image. If
 * this is called, it will no longer do this.
 * Warning: If the aspect ratio is not kept, the camera feed may be
 * stretched and no longer be a proper representation of what is recorded.
 *
 * beep: true
 * Enables or disables the sound played when a code was recognized.
 *
 * vibrate: true
 * Enables or disables the vibration when a code was recognized.
 *
 * uiFont: "Helvetica"
 * Sets the font of all text displayed in the UI (must be known by iOS).
 *
 * textForMostLikelyBarcodeUIElement: "Tap to use"
 * Sets the text that will be displayed alongside the lucky shot to tell the user what to do, to
 * use the displayed barcode.
 *
 * textForInitialScanScreenState: "Align code with box"
 * Sets the text that will be displayed above the viewfinder to tell the user to align it with the
 * barcode that should be recognized.
 *
 * textForBarcodePresenceDetected: "Align code and hold still"
 * Sets the text that will be displayed above the viewfinder to tell the user to align it with the
 * barcode and hold still because a potential code seems to be on the screen.
 *
 * textForBarcodeDecodingInProgress: "Decoding ..."
 * Sets the text that will be displayed above the viewfinder to tell the user to hold still because
 * a barcode is aligned with the box and the recognition is trying to recognize it.
 *
 * searchBarActionButtonCaption: "Go"
 * Sets the caption of the manual entry at the top when a barcode of valid length has been entered.
 *
 * searchBarCancelButtonCaption: "Cancel"
 * Sets the caption of the manual entry at the top when no barcode of valid length has been entered.
 *
 * searchBarPlaceholderText: "Scan barcode or enter it here"
 * Sets the text shown in the manual entry field when nothing has been entered yet.
 *
 * toolBarButtonCaption: "Cancel"
 * Sets the caption of the toolbar button.
 *
 * viewfinderColor: "FFFFFF"
 * Sets the color of the static viewfinder and while tracking before the code has been recognized.
 *
 * viewfinderDecodedColor: "00FF00"
 * Sets the color of the viewfinder when the code has been recognized.
 *
 * minSearchBarBarcodeLength: 8
 * Sets the minimum size a barcode in the manual entry field has to have to possibly be valid.
 *
 * maxSearchBarBarcodeLength: 100
 * Sets the maximum size a barcode in the manual entry field can have to possibly be valid.
 */
- (void)scan:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
