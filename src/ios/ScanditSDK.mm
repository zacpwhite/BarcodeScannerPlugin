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

#import "ScanditSDK.h"
#import "ScanditSDKRotatingBarcodePicker.h"
#import "ScanditSDKParameterParser.h"


@interface ScanditSDK ()
@property (nonatomic, copy) NSString *callbackId;
@property (readwrite, assign) BOOL hasPendingOperation;
@property (nonatomic, assign) BOOL continuousMode;
@property (nonatomic, assign) BOOL modallyPresented;
@property (nonatomic, assign) BOOL startAnimationDone;
@property (nonatomic, strong) NSDictionary *bufferedResult;
@property (nonatomic, strong) ScanditSDKRotatingBarcodePicker *scanditSDKBarcodePicker;
@end


@implementation ScanditSDK

@synthesize hasPendingOperation;

- (void)scan:(CDVInvokedUrlCommand *)command {
    if (self.hasPendingOperation) {
        return;
    }
    self.hasPendingOperation = YES;
    
    NSUInteger argc = [command.arguments count];
    if (argc < 2) {
        NSLog(@"The scan call received too few arguments and has to return without starting.");
        return;
    }
    self.callbackId = command.callbackId;
    
    NSString *appKey = [command.arguments objectAtIndex:0];
	NSDictionary *options = [command.arguments objectAtIndex:1];

    // Continuous mode support
    self.continuousMode = NO;
    NSObject *continuousMode = [options objectForKey:@"continuousMode"];
    if (continuousMode && [continuousMode isKindOfClass:[NSNumber class]]) {
        self.continuousMode = [((NSNumber *)continuousMode) boolValue];
    }
	
	CameraFacingDirection facing = CAMERA_FACING_BACK;
    NSObject *preferFrontCamera = [options objectForKey:@"preferFrontCamera"];
    if (preferFrontCamera && [preferFrontCamera isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)preferFrontCamera) boolValue]) {
			facing = CAMERA_FACING_FRONT;
		}
    }
	
	NSMutableArray *orientations = nil;
    NSObject *orientationsObj = [options objectForKey:@"orientations"];
    if (orientationsObj && [orientationsObj isKindOfClass:[NSString class]]) {
		NSString *orientationsString = (NSString *)orientationsObj;
		orientations = [[NSMutableArray alloc] init];
		if ([orientationsString rangeOfString:@"portrait"].location != NSNotFound) {
			[orientations addObject:@"UIInterfaceOrientationPortrait"];
		}
		if ([orientationsString rangeOfString:@"portraitUpsideDown"].location != NSNotFound) {
			[orientations addObject:@"UIInterfaceOrientationPortraitUpsideDown"];
		}
		if ([orientationsString rangeOfString:@"landscapeLeft"].location != NSNotFound) {
			[orientations addObject:@"UIInterfaceOrientationLandscapeLeft"];
		}
		if ([orientationsString rangeOfString:@"landscapeRight"].location != NSNotFound) {
			[orientations addObject:@"UIInterfaceOrientationLandscapeRight"];
		}
	}
    
    self.scanditSDKBarcodePicker = [[ScanditSDKRotatingBarcodePicker alloc]
                                    initWithAppKey:appKey
                                    cameraFacingPreference:facing
                                    orientations:orientations];
	
    NSObject *disableStandby = [options objectForKey:@"disableStandbyState"];
	if (disableStandby && [disableStandby isKindOfClass:[NSNumber class]]) {
		if ([((NSNumber *)disableStandby) boolValue]) {
			[self.scanditSDKBarcodePicker disableStandbyState];
		}
	}
	
    NSObject *searchBar = [options objectForKey:@"searchBar"];
    if (searchBar && [searchBar isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController showSearchBar:[((NSNumber *)searchBar) boolValue]];
    }
	
    // Set the options.
    NSObject *scanning1D = [options objectForKey:@"1DScanning"];
    if (scanning1D && [scanning1D isKindOfClass:[NSNumber class]]) {
        NSLog(@"The parameter '1DScanning' is deprecated. Please enable symbologies individually instead");
        [self.scanditSDKBarcodePicker set1DScanningEnabled:[((NSNumber *)scanning1D) boolValue]];
    }
    NSObject *scanning2D = [options objectForKey:@"2DScanning"];
    if (scanning2D && [scanning2D isKindOfClass:[NSNumber class]]) {
        NSLog(@"The parameter '2DScanning' is deprecated. Please enable symbologies individually instead");
        [self.scanditSDKBarcodePicker set2DScanningEnabled:[((NSNumber *)scanning2D) boolValue]];
    }
    
    NSObject *ean13AndUpc12 = [options objectForKey:@"ean13AndUpc12"];
    if (ean13AndUpc12 && [ean13AndUpc12 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setEan13AndUpc12Enabled:[((NSNumber *)ean13AndUpc12) boolValue]];
    }
    NSObject *ean8 = [options objectForKey:@"ean8"];
    if (ean8 && [ean8 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setEan8Enabled:[((NSNumber *)ean8) boolValue]];
    }
    NSObject *upce = [options objectForKey:@"upce"];
    if (upce && [upce isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setUpceEnabled:[((NSNumber *)upce) boolValue]];
    }
    NSObject *code39 = [options objectForKey:@"code39"];
    if (code39 && [code39 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setCode39Enabled:[((NSNumber *)code39) boolValue]];
    }
    NSObject *code93 = [options objectForKey:@"code93"];
    if (code93 && [code93 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setCode93Enabled:[((NSNumber *)code93) boolValue]];
    }
    NSObject *code128 = [options objectForKey:@"code128"];
    if (code128 && [code128 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setCode128Enabled:[((NSNumber *)code128) boolValue]];
    }
    NSObject *gs1DataBar = [options objectForKey:@"gs1DataBar"];
    if (gs1DataBar && [gs1DataBar isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setGS1DataBarEnabled:[((NSNumber *)gs1DataBar) boolValue]];
    }
    NSObject *gs1DataBarExpanded = [options objectForKey:@"gs1DataBarExpanded"];
    if (gs1DataBarExpanded && [gs1DataBarExpanded isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setGS1DataBarExpandedEnabled:[((NSNumber *)gs1DataBarExpanded) boolValue]];
    }
    NSObject *itf = [options objectForKey:@"itf"];
    if (itf && [itf isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setItfEnabled:[((NSNumber *)itf) boolValue]];
    }
    NSObject *codabar = [options objectForKey:@"codabar"];
    if (codabar && [codabar isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setCodabarEnabled:[((NSNumber *)codabar) boolValue]];
    }
    NSObject *qr = [options objectForKey:@"qr"];
    if (qr && [qr isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setQrEnabled:[((NSNumber *)qr) boolValue]];
    }
    NSObject *dataMatrix = [options objectForKey:@"dataMatrix"];
    if (dataMatrix && [dataMatrix isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setDataMatrixEnabled:[((NSNumber *)dataMatrix) boolValue]];
    }
    NSObject *pdf417 = [options objectForKey:@"pdf417"];
    if (pdf417 && [pdf417 isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setPdf417Enabled:[((NSNumber *)pdf417) boolValue]];
    }
    NSObject *aztec = [options objectForKey:@"aztec"];
    if (aztec && [aztec isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setAztecEnabled:[((NSNumber *)aztec) boolValue]];
    }
    NSObject *msiPlessey = [options objectForKey:@"msiPlessey"];
    if (msiPlessey && [msiPlessey isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setMsiPlesseyEnabled:[((NSNumber *)msiPlessey) boolValue]];
    }
    
    NSObject *msiPlesseyChecksum = [options objectForKey:@"msiPlesseyChecksumType"];
    if (msiPlesseyChecksum && [msiPlesseyChecksum isKindOfClass:[NSString class]]) {
        NSString *msiPlesseyChecksumString = (NSString *)msiPlesseyChecksum;
        if ([msiPlesseyChecksumString isEqualToString:@"none"]) {
			[self.scanditSDKBarcodePicker setMsiPlesseyChecksumType:NONE];
        } else if ([msiPlesseyChecksumString isEqualToString:@"mod11"]) {
			[self.scanditSDKBarcodePicker setMsiPlesseyChecksumType:CHECKSUM_MOD_11];
		} else if ([msiPlesseyChecksumString isEqualToString:@"mod1010"]) {
			[self.scanditSDKBarcodePicker setMsiPlesseyChecksumType:CHECKSUM_MOD_1010];
		} else if ([msiPlesseyChecksumString isEqualToString:@"mod1110"]) {
			[self.scanditSDKBarcodePicker setMsiPlesseyChecksumType:CHECKSUM_MOD_1110];
		} else {
			[self.scanditSDKBarcodePicker setMsiPlesseyChecksumType:CHECKSUM_MOD_10];
		}
    }
    
    NSObject *inverseRecognition = [options objectForKey:@"inverseRecognition"];
    if (inverseRecognition && [inverseRecognition isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setInverseDetectionEnabled:[((NSNumber *)inverseRecognition) boolValue]];
    }
    NSObject *microDataMatrix = [options objectForKey:@"microDataMatrix"];
    if (microDataMatrix && [microDataMatrix isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setMicroDataMatrixEnabled:[((NSNumber *)microDataMatrix) boolValue]];
    }
    NSObject *force2d = [options objectForKey:@"force2d"];
    if (force2d && [force2d isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker force2dRecognition:[((NSNumber *)force2d) boolValue]];
    }
	
    NSObject *restrictActiveScanningArea = [options objectForKey:@"restrictActiveScanningArea"];
    if (restrictActiveScanningArea && [restrictActiveScanningArea isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker
		 restrictActiveScanningArea:[((NSNumber *)restrictActiveScanningArea) boolValue]];
    }
    
    [self adjustUIWithOptions:options];
    
    [self adjustLayoutWithOptions:options animationDuration:0];
    
    // Set this class as the delegate for the overlay controller. It will now receive events when
    // a barcode was successfully scanned, manually entered or the cancel button was pressed.
    self.scanditSDKBarcodePicker.overlayController.delegate = self;
    
    if ([options objectForKey:@"portraitMargins"] || [options objectForKey:@"landscapeMargins"]) {
        self.modallyPresented = NO;
        [self.viewController addChildViewController:self.scanditSDKBarcodePicker];
        [self.viewController.view addSubview:self.scanditSDKBarcodePicker.view];
        [self.scanditSDKBarcodePicker didMoveToParentViewController:self.viewController];
        
    } else {
        self.modallyPresented = YES;
        
        // Show the toolbar that contains a cancel button.
        [self.scanditSDKBarcodePicker.overlayController showToolBar:YES];
        
        self.startAnimationDone = NO;
        self.bufferedResult = nil;
        
        // Present the barcode picker modally and start scanning.
        if ([self.viewController respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [self.viewController presentViewController:self.scanditSDKBarcodePicker animated:YES completion:^{
                self.startAnimationDone = YES;
                if (self.bufferedResult != nil) {
                    [self performSelector:@selector(returnBuffer) withObject:nil afterDelay:0.01];
                }
            }];
        } else {
            [self.viewController presentModalViewController:self.scanditSDKBarcodePicker animated:NO];
            self.startAnimationDone = YES;
        }
    }
    
    [self.scanditSDKBarcodePicker performSelector:@selector(startScanning) withObject:nil afterDelay:0.1];
}

- (void)returnBuffer {
	if (self.bufferedResult != nil) {
		[self scanditSDKOverlayController:self.scanditSDKBarcodePicker.overlayController
						   didScanBarcode:self.bufferedResult];
		self.bufferedResult = nil;
	}
}

- (void)cancel:(CDVInvokedUrlCommand *)command {
    if (self.scanditSDKBarcodePicker) {
        [self scanditSDKOverlayController:self.scanditSDKBarcodePicker.overlayController
                      didCancelWithStatus:nil];
    }
}

- (void)pause:(CDVInvokedUrlCommand *)command {
    [self.scanditSDKBarcodePicker stopScanning];
}

- (void)resume:(CDVInvokedUrlCommand *)command {
    [self.scanditSDKBarcodePicker startScanning];
}

- (void)start:(CDVInvokedUrlCommand *)command {
    [self.scanditSDKBarcodePicker startScanning];
}

- (void)stop:(CDVInvokedUrlCommand *)command {
    [self.scanditSDKBarcodePicker stopScanningAndFreeze];
}

- (void)resize:(CDVInvokedUrlCommand *)command {
    if (self.scanditSDKBarcodePicker && !self.modallyPresented) {
        NSUInteger argc = [command.arguments count];
        if (argc < 1) {
            NSLog(@"The updateLayout call received too few arguments and has to return without starting.");
            return;
        }
        self.callbackId = command.callbackId;
        
        NSDictionary *options = [command.arguments objectAtIndex:0];
        
        [self adjustUIWithOptions:options];
        
        CGFloat animation = 0;
        NSObject *animationDuration = [options objectForKey:@"animationDuration"];
        if (animationDuration && [animationDuration isKindOfClass:[NSNumber class]]) {
            animation = [((NSNumber *)animationDuration) floatValue];
        }
        [self adjustLayoutWithOptions:options animationDuration:animation];
    }
}

- (void)adjustUIWithOptions:(NSDictionary *)options {
    
    NSObject *scanningHotspot = [options objectForKey:@"scanningHotspot"];
    if (scanningHotspot && [scanningHotspot isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) scanningHotspot) componentsSeparatedByString:@"/"];
        if ([split count] == 2) {
            float x = [[split objectAtIndex:0] floatValue];
            float y = [[split objectAtIndex:1] floatValue];
            [self.scanditSDKBarcodePicker setScanningHotSpotToX:x andY:y];
        }
    }
    NSObject *scanningHotspotHeight = [options objectForKey:@"scanningHotspotHeight"];
    if (scanningHotspotHeight && [scanningHotspotHeight isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker setScanningHotSpotHeight:[((NSNumber *)scanningHotspotHeight) floatValue]];
    }
    NSObject *viewfinderSize = [options objectForKey:@"viewfinderSize"];
    if (viewfinderSize && [viewfinderSize isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) viewfinderSize) componentsSeparatedByString:@"/"];
        if ([split count] == 4) {
            float width = [[split objectAtIndex:0] floatValue];
            float height = [[split objectAtIndex:1] floatValue];
            float landscapeWidth = [[split objectAtIndex:2] floatValue];
            float landscapeHeight = [[split objectAtIndex:3] floatValue];
            [self.scanditSDKBarcodePicker.overlayController setViewfinderHeight:height
                                                                          width:width
                                                                landscapeHeight:landscapeHeight
                                                                 landscapeWidth:landscapeWidth];
        }
    }
    
    NSObject *beep = [options objectForKey:@"beep"];
    if (beep && [beep isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController setBeepEnabled:[((NSNumber *)beep) boolValue]];
    }
    NSObject *vibrate = [options objectForKey:@"vibrate"];
    if (vibrate && [vibrate isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController setVibrateEnabled:[((NSNumber *)vibrate) boolValue]];
    }
    
    NSObject *torch = [options objectForKey:@"torch"];
    if (torch && [torch isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController setTorchEnabled:[((NSNumber *)torch) boolValue]];
    }
    NSObject *torchButtonPositionAndSize = [options objectForKey:@"torchButtonPositionAndSize"];
    if (torchButtonPositionAndSize) {
        CGRect buttonRect = [ScanditSDKParameterParser rectFromParameter:torchButtonPositionAndSize];
        [self.scanditSDKBarcodePicker.overlayController setTorchButtonRelativeX:buttonRect.origin.x
                                                                      relativeY:buttonRect.origin.y
                                                                          width:buttonRect.size.width
                                                                         height:buttonRect.size.height];
    }
    NSObject *cameraSwitchVisibility = [options objectForKey:@"cameraSwitchVisibility"];
    if (cameraSwitchVisibility && [cameraSwitchVisibility isKindOfClass:[NSString class]]) {
        NSString *cameraSwitchVisibilityString = (NSString *)cameraSwitchVisibility;
        if ([cameraSwitchVisibilityString isEqualToString:@"tablet"]) {
            [self.scanditSDKBarcodePicker.overlayController setCameraSwitchVisibility:CAMERA_SWITCH_ON_TABLET];
        } else if ([cameraSwitchVisibilityString isEqualToString:@"always"]) {
            [self.scanditSDKBarcodePicker.overlayController setCameraSwitchVisibility:CAMERA_SWITCH_ALWAYS];
        } else {
            [self.scanditSDKBarcodePicker.overlayController setCameraSwitchVisibility:CAMERA_SWITCH_NEVER];
        }
    }
    NSObject *cameraSwitchButton = [options objectForKey:@"cameraSwitchButtonPositionAndSize"];
    if (cameraSwitchButton) {
        CGRect buttonRect = [ScanditSDKParameterParser rectFromParameter:cameraSwitchButton];
        [self.scanditSDKBarcodePicker.overlayController
         setCameraSwitchButtonRelativeInverseX:buttonRect.origin.x
         relativeY:buttonRect.origin.y
         width:buttonRect.size.width
         height:buttonRect.size.height];
    }

    NSObject *logoOffsets = [options objectForKey:@"logoOffsets"];
    if (logoOffsets && [logoOffsets isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) logoOffsets) componentsSeparatedByString:@"/"];
        if ([split count] == 4) {
            int xOffset = [[split objectAtIndex:0] floatValue];
            int yOffset = [[split objectAtIndex:1] floatValue];
            int landscapeXOffset = [[split objectAtIndex:2] intValue];
            int landscapeYOffset = [[split objectAtIndex:3] intValue];
            [self.scanditSDKBarcodePicker.overlayController setLogoXOffset:xOffset
                                                                   yOffset:yOffset
                                                          landscapeXOffset:landscapeXOffset
                                                          landscapeYOffset:landscapeYOffset];
        }
    }
    
    NSObject *t5 = [options objectForKey:@"searchBarActionButtonCaption"];
    if (t5 && [t5 isKindOfClass:[NSString class]]) {
        [self.scanditSDKBarcodePicker.overlayController setSearchBarActionButtonCaption:((NSString *) t5)];
    }
    NSObject *t6 = [options objectForKey:@"searchBarCancelButtonCaption"];
    if (t6 && [t6 isKindOfClass:[NSString class]]) {
        [self.scanditSDKBarcodePicker.overlayController setSearchBarCancelButtonCaption:((NSString *) t6)];
    }
    NSObject *t7 = [options objectForKey:@"searchBarPlaceholderText"];
    if (t7 && [t7 isKindOfClass:[NSString class]]) {
        [self.scanditSDKBarcodePicker.overlayController setSearchBarPlaceholderText:((NSString *) t7)];
    }
    NSObject *t8 = [options objectForKey:@"toolBarButtonCaption"];
    if (t8 && [t8 isKindOfClass:[NSString class]]) {
        [self.scanditSDKBarcodePicker.overlayController setToolBarButtonCaption:((NSString *) t8)];
    }
    
    
    NSObject *color1 = [options objectForKey:@"viewfinderColor"];
    if (color1 && [color1 isKindOfClass:[NSString class]]) {
        NSString *color1String = (NSString *)color1;
        if ([color1String length] == 6) {
            unsigned int redInt;
            NSScanner *redScanner = [NSScanner scannerWithString:[color1String substringToIndex:2]];
            [redScanner scanHexInt:&redInt];
            float red = ((float) redInt) / 256.0;
            
            unsigned int greenInt;
            NSScanner *greenScanner = [NSScanner scannerWithString:[[color1String substringFromIndex:2] substringToIndex:2]];
            [greenScanner scanHexInt:&greenInt];
            float green = ((float) greenInt) / 256.0;
            
            unsigned int blueInt;
            NSScanner *blueScanner = [NSScanner scannerWithString:[color1String substringFromIndex:4]];
            [blueScanner scanHexInt:&blueInt];
            float blue = ((float) blueInt) / 256.0;
            
            [self.scanditSDKBarcodePicker.overlayController setViewfinderColor:red green:green blue:blue];
        }
    }
    NSObject *color2 = [options objectForKey:@"viewfinderDecodedColor"];
    if (color2 && [color2 isKindOfClass:[NSString class]]) {
        NSString *color2String = (NSString *)color2;
        if ([color2String length] == 6) {
            unsigned int redInt;
            NSScanner *redScanner = [NSScanner scannerWithString:[color2String substringToIndex:2]];
            [redScanner scanHexInt:&redInt];
            float red = ((float) redInt) / 256.0;
            
            unsigned int greenInt;
            NSScanner *greenScanner = [NSScanner scannerWithString:[[color2String substringFromIndex:2] substringToIndex:2]];
            [greenScanner scanHexInt:&greenInt];
            float green = ((float) greenInt) / 256.0;
            
            unsigned int blueInt;
            NSScanner *blueScanner = [NSScanner scannerWithString:[color2String substringFromIndex:4]];
            [blueScanner scanHexInt:&blueInt];
            float blue = ((float) blueInt) / 256.0;
            
            [self.scanditSDKBarcodePicker.overlayController setViewfinderDecodedColor:red green:green blue:blue];
        }
    }
    
    NSObject *minManual = [options objectForKey:@"minSearchBarBarcodeLength"];
    if (minManual && [minManual isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController setMinSearchBarBarcodeLength:[((NSNumber *) minManual) integerValue]];
    }
    NSObject *maxManual = [options objectForKey:@"maxSearchBarBarcodeLength"];
    if (maxManual && [maxManual isKindOfClass:[NSNumber class]]) {
        [self.scanditSDKBarcodePicker.overlayController setMaxSearchBarBarcodeLength:[((NSNumber *) maxManual) integerValue]];
    }
}

- (void)adjustLayoutWithOptions:(NSDictionary *)options animationDuration:(CGFloat)animationDuration {
    int longSide = MAX(self.viewController.view.frame.size.width,
                       self.viewController.view.frame.size.height);
    int shortSide = MIN(self.viewController.view.frame.size.width,
                        self.viewController.view.frame.size.height);
    
    NSObject *portraitMargins = [options objectForKey:@"portraitMargins"];
    NSObject *landscapeMargins = [options objectForKey:@"landscapeMargins"];
    if (portraitMargins || landscapeMargins) {
        self.scanditSDKBarcodePicker.portraitSize = CGRectMake(0, 0, shortSide, longSide);
        self.scanditSDKBarcodePicker.landscapeSize = CGRectMake(0, 0, longSide, shortSide);
    }
    
    if (portraitMargins) {
        CGRect margins = [ScanditSDKParameterParser rectFromParameter:portraitMargins];
        self.scanditSDKBarcodePicker.portraitSize = CGRectMake(margins.origin.x, margins.origin.y,
                                                               shortSide - margins.size.width - margins.origin.x,
                                                               longSide - margins.size.height - margins.origin.y);
    }
    if (landscapeMargins) {
        CGRect margins = [ScanditSDKParameterParser rectFromParameter:landscapeMargins];
        self.scanditSDKBarcodePicker.portraitSize = CGRectMake(margins.origin.x, margins.origin.y,
                                                               shortSide - margins.size.width - margins.origin.x,
                                                               longSide - margins.size.height - margins.origin.y);
    }
    
    [self.scanditSDKBarcodePicker adjustSize:animationDuration];
}


#pragma mark - ScanDKOverlayControllerDelegate methods

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController1
                     didScanBarcode:(NSDictionary *)barcodeResult {
    if (self.modallyPresented) {
        if (!self.startAnimationDone) {
            // If the initial animation hasn't finished yet we buffer the result and return it as soon
            // as the animation finishes.
            self.bufferedResult = barcodeResult;
            return;
        } else {
            self.bufferedResult = nil;
        }
    }
	
    // Prepare result
	NSString *symbology = [barcodeResult objectForKey:@"symbology"];
	NSString *barcode = [barcodeResult objectForKey:@"barcode"];
    
    NSArray *result = [[NSArray alloc] initWithObjects:barcode, symbology, nil];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                       messageAsArray:result];
    
    if (!self.continuousMode) {
        [self.scanditSDKBarcodePicker stopScanning];
        if (self.modallyPresented) {
            [self.viewController dismissModalViewControllerAnimated:YES];
        } else {
            [self.scanditSDKBarcodePicker removeFromParentViewController];
            [self.scanditSDKBarcodePicker.view removeFromSuperview];
            [self.scanditSDKBarcodePicker didMoveToParentViewController:nil];
        }
        self.scanditSDKBarcodePicker = nil;
        self.hasPendingOperation = NO;
    } else {
        [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    }
	
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController1
                didCancelWithStatus:(NSDictionary *)status {
    
    [self.scanditSDKBarcodePicker stopScanning];
    if (self.modallyPresented) {
        [self.viewController dismissModalViewControllerAnimated:YES];
    } else {
        [self.scanditSDKBarcodePicker removeFromParentViewController];
        [self.scanditSDKBarcodePicker.view removeFromSuperview];
        [self.scanditSDKBarcodePicker didMoveToParentViewController:nil];
    }
	self.scanditSDKBarcodePicker = nil;
    
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                      messageAsString:@"Canceled"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId]; 
    self.hasPendingOperation = NO;
}

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController
                    didManualSearch:(NSString *)input {
	
    NSArray *result = [[NSArray alloc] initWithObjects:input, @"UNKNOWN", nil];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                       messageAsArray:result];
    if (!self.continuousMode) {
        [self.scanditSDKBarcodePicker stopScanning];
        if (self.modallyPresented) {
            [self.viewController dismissModalViewControllerAnimated:YES];
        } else {
            [self.scanditSDKBarcodePicker removeFromParentViewController];
            [self.scanditSDKBarcodePicker.view removeFromSuperview];
            [self.scanditSDKBarcodePicker didMoveToParentViewController:nil];
        }
        self.scanditSDKBarcodePicker = nil;
        self.hasPendingOperation = NO;
    } else {
        [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.scanditSDKBarcodePicker.overlayController resetUI];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}



@end
