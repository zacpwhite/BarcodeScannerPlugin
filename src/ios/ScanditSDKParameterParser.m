//
//  ScanditSDKParameterParser.m
//  Hello World
//
//  Created by Moritz Hartmeier on 10/06/15.
//
//

#import "ScanditSDKParameterParser.h"


@implementation ScanditSDKParameterParser

+ (SBSScanSettings *)settingsForOptions:(NSDictionary *)options {
    SBSScanSettings *settings = [SBSScanSettings pre47DefaultSettings];
    
    SBSCameraFacingDirection facing = SBSCameraFacingDirectionBack;
    NSObject *preferFrontCamera = [options objectForKey:@"preferFrontCamera"];
    if (preferFrontCamera && [preferFrontCamera isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)preferFrontCamera) boolValue]) {
            facing = SBSCameraFacingDirectionFront;
        }
    }
    
    // Set the options.
    NSObject *scanning1D = [options objectForKey:@"1DScanning"];
    if (scanning1D && [scanning1D isKindOfClass:[NSNumber class]]) {
        NSLog(@"The parameter '1DScanning' is deprecated. Please enable symbologies individually instead");
        [settings enableSymbologies:[NSSet setWithObjects:
                                     [NSNumber numberWithInt:SBSSymbologyEAN13],
                                     [NSNumber numberWithInt:SBSSymbologyUPC12],
                                     [NSNumber numberWithInt:SBSSymbologyEAN8],
                                     [NSNumber numberWithInt:SBSSymbologyCode128],
                                     [NSNumber numberWithInt:SBSSymbologyCode39],
                                     [NSNumber numberWithInt:SBSSymbologyCode93],
                                     [NSNumber numberWithInt:SBSSymbologyITF],
                                     [NSNumber numberWithInt:SBSSymbologyMSIPlessey],
                                     [NSNumber numberWithInt:SBSSymbologyUPCE],
                                     [NSNumber numberWithInt:SBSSymbologyCodabar],
                                     [NSNumber numberWithInt:SBSSymbologyGS1Databar],
                                     [NSNumber numberWithInt:SBSSymbologyGS1DatabarExpanded], nil]];
    }
    NSObject *scanning2D = [options objectForKey:@"2DScanning"];
    if (scanning2D && [scanning2D isKindOfClass:[NSNumber class]]) {
        NSLog(@"The parameter '2DScanning' is deprecated. Please enable symbologies individually instead");
        [settings enableSymbologies:[NSSet setWithObjects:
                                     [NSNumber numberWithInt:SBSSymbologyAztec],
                                     [NSNumber numberWithInt:SBSSymbologyDatamatrix],
                                     [NSNumber numberWithInt:SBSSymbologyPDF417],
                                     [NSNumber numberWithInt:SBSSymbologyQR], nil]];
    }
    
    NSObject *ean13AndUpc12 = [options objectForKey:@"ean13AndUpc12"];
    if (ean13AndUpc12 && [ean13AndUpc12 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyEAN13 enabled:[((NSNumber *)ean13AndUpc12) boolValue]];
        [settings setSymbology:SBSSymbologyUPC12 enabled:[((NSNumber *)ean13AndUpc12) boolValue]];
    }
    NSObject *ean8 = [options objectForKey:@"ean8"];
    if (ean8 && [ean8 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyEAN8 enabled:[((NSNumber *)ean8) boolValue]];
    }
    NSObject *upce = [options objectForKey:@"upce"];
    if (upce && [upce isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyUPCE enabled:[((NSNumber *)upce) boolValue]];
    }
    NSObject *code39 = [options objectForKey:@"code39"];
    if (code39 && [code39 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyCode39 enabled:[((NSNumber *)code39) boolValue]];
    }
    NSObject *code93 = [options objectForKey:@"code93"];
    if (code93 && [code93 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyCode93 enabled:[((NSNumber *)code93) boolValue]];
    }
    NSObject *code128 = [options objectForKey:@"code128"];
    if (code128 && [code128 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyCode128 enabled:[((NSNumber *)code128) boolValue]];
    }
    NSObject *itf = [options objectForKey:@"itf"];
    if (itf && [itf isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyITF enabled:[((NSNumber *)itf) boolValue]];
    }
    NSObject *gs1DataBar = [options objectForKey:@"gs1DataBar"];
    if (gs1DataBar && [gs1DataBar isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyGS1Databar enabled:[((NSNumber *)gs1DataBar) boolValue]];
    }
    NSObject *gs1DataBarExpanded = [options objectForKey:@"gs1DataBarExpanded"];
    if (gs1DataBarExpanded && [gs1DataBarExpanded isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyGS1DatabarExpanded enabled:[((NSNumber *)gs1DataBarExpanded) boolValue]];
    }
    NSObject *codabar = [options objectForKey:@"codabar"];
    if (codabar && [codabar isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyCodabar enabled:[((NSNumber *)codabar) boolValue]];
    }
    NSObject *qr = [options objectForKey:@"qr"];
    if (qr && [qr isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyQR enabled:[((NSNumber *)qr) boolValue]];
    }
    NSObject *dataMatrix = [options objectForKey:@"dataMatrix"];
    if (dataMatrix && [dataMatrix isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyDatamatrix enabled:[((NSNumber *)dataMatrix) boolValue]];
    }
    NSObject *pdf417 = [options objectForKey:@"pdf417"];
    if (pdf417 && [pdf417 isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyPDF417 enabled:[((NSNumber *)pdf417) boolValue]];
    }
    NSObject *aztec = [options objectForKey:@"aztec"];
    if (aztec && [aztec isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyAztec enabled:[((NSNumber *)aztec) boolValue]];
    }
    NSObject *msiPlessey = [options objectForKey:@"msiPlessey"];
    if (msiPlessey && [msiPlessey isKindOfClass:[NSNumber class]]) {
        [settings setSymbology:SBSSymbologyMSIPlessey enabled:[((NSNumber *)msiPlessey) boolValue]];
    }
    
    NSObject *msiPlesseyChecksum = [options objectForKey:@"msiPlesseyChecksumType"];
    if (msiPlesseyChecksum && [msiPlesseyChecksum isKindOfClass:[NSString class]]) {
        NSString *msiPlesseyChecksumString = (NSString *)msiPlesseyChecksum;
        NSMutableSet *msiChecksums = [NSMutableSet set];
        if ([msiPlesseyChecksumString isEqualToString:@"none"]) {
            [msiChecksums addObject:[NSNumber numberWithInt:SBSChecksumNone]];
        } else if ([msiPlesseyChecksumString isEqualToString:@"mod11"]) {
            [msiChecksums addObject:[NSNumber numberWithInt:SBSChecksumMod11]];
        } else if ([msiPlesseyChecksumString isEqualToString:@"mod1010"]) {
            [msiChecksums addObject:[NSNumber numberWithInt:SBSChecksumMod1010]];
        } else if ([msiPlesseyChecksumString isEqualToString:@"mod1110"]) {
            [msiChecksums addObject:[NSNumber numberWithInt:SBSChecksumMod1110]];
        } else {
            [msiChecksums addObject:[NSNumber numberWithInt:SBSChecksumMod10]];
        }
        [settings settingsForSymbology:SBSSymbologyMSIPlessey].checksums = msiChecksums;
    }
    
    NSObject *inverseRecognition = [options objectForKey:@"inverseRecognition"];
    if (inverseRecognition && [inverseRecognition isKindOfClass:[NSNumber class]]) {
        SBSSymbologySettings *dataMatrixSettings = [settings settingsForSymbology:SBSSymbologyDatamatrix];
        dataMatrixSettings.colorInvertedEnabled = [((NSNumber *)inverseRecognition) boolValue];
    }
    NSObject *microDataMatrix = [options objectForKey:@"microDataMatrix"];
    if (microDataMatrix && [microDataMatrix isKindOfClass:[NSNumber class]]) {
        SBSSymbologySettings *dataMatrixSettings = [settings settingsForSymbology:SBSSymbologyDatamatrix];
        [dataMatrixSettings setExtension:SBSSymbologySettingsExtensionTiny
                                 enabled:[((NSNumber *)microDataMatrix) boolValue]];
    }
    NSObject *force2d = [options objectForKey:@"force2d"];
    if (force2d && [force2d isKindOfClass:[NSNumber class]]) {
        settings.force2dRecognition = [((NSNumber *)force2d) boolValue];
    }
    
    NSObject *codeDuplicateFilter = [options objectForKey:@"codeDuplicateFilter"];
    if (codeDuplicateFilter && [codeDuplicateFilter isKindOfClass:[NSNumber class]]) {
        settings.codeDuplicateFilter = [((NSNumber *)codeDuplicateFilter) floatValue];
    }
    
    NSObject *scanningHotspot = [options objectForKey:@"scanningHotspot"];
    if (scanningHotspot && [scanningHotspot isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) scanningHotspot) componentsSeparatedByString:@"/"];
        if ([split count] == 2) {
            float x = [[split objectAtIndex:0] floatValue];
            float y = [[split objectAtIndex:1] floatValue];
            settings.scanningHotSpot = CGPointMake(x, y);
        }
    }
    NSObject *scanningHotspotHeight = [options objectForKey:@"scanningHotspotHeight"];
    if (scanningHotspotHeight && [scanningHotspotHeight isKindOfClass:[NSNumber class]]) {
        int height = [((NSNumber *)scanningHotspotHeight) intValue];
        CGRect activeScanArea = CGRectMake(0.0f, settings.scanningHotSpot.y - height * 0.5f, 1.0f, height);
        [settings setActiveScanningArea:activeScanArea];
    }
    
    return settings;
}

+ (void)updatePickerUI:(SBSBarcodePicker *)picker fromOptions:(NSDictionary *)options {
    NSObject *viewfinderSize = [options objectForKey:@"viewfinderSize"];
    if (viewfinderSize && [viewfinderSize isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) viewfinderSize) componentsSeparatedByString:@"/"];
        if ([split count] == 4) {
            float width = [[split objectAtIndex:0] floatValue];
            float height = [[split objectAtIndex:1] floatValue];
            float landscapeWidth = [[split objectAtIndex:2] floatValue];
            float landscapeHeight = [[split objectAtIndex:3] floatValue];
            [picker.overlayController setViewfinderHeight:height
                                                    width:width
                                          landscapeHeight:landscapeHeight
                                           landscapeWidth:landscapeWidth];
        }
    }
    
    NSObject *beep = [options objectForKey:@"beep"];
    if (beep && [beep isKindOfClass:[NSNumber class]]) {
        [picker.overlayController setBeepEnabled:[((NSNumber *)beep) boolValue]];
    }
    NSObject *vibrate = [options objectForKey:@"vibrate"];
    if (vibrate && [vibrate isKindOfClass:[NSNumber class]]) {
        [picker.overlayController setVibrateEnabled:[((NSNumber *)vibrate) boolValue]];
    }
    
    NSObject *torch = [options objectForKey:@"torch"];
    if (torch && [torch isKindOfClass:[NSNumber class]]) {
        [picker.overlayController setTorchEnabled:[((NSNumber *)torch) boolValue]];
    }
    NSObject *torchButtonMarginsAndSize = [options objectForKey:@"torchButtonMarginsAndSize"];
    if (torchButtonMarginsAndSize) {
        CGRect buttonRect = [ScanditSDKParameterParser rectFromParameter:torchButtonMarginsAndSize];
        [picker.overlayController setTorchButtonLeftMargin:buttonRect.origin.x
                                                 topMargin:buttonRect.origin.y
                                                     width:buttonRect.size.width
                                                    height:buttonRect.size.height];
    }
    NSObject *cameraSwitchVisibility = [options objectForKey:@"cameraSwitchVisibility"];
    if (cameraSwitchVisibility && [cameraSwitchVisibility isKindOfClass:[NSString class]]) {
        NSString *cameraSwitchVisibilityString = (NSString *)cameraSwitchVisibility;
        if ([cameraSwitchVisibilityString isEqualToString:@"tablet"]) {
            [picker.overlayController setCameraSwitchVisibility:SBSCameraSwitchVisibilityOnTablet];
        } else if ([cameraSwitchVisibilityString isEqualToString:@"always"]) {
            [picker.overlayController setCameraSwitchVisibility:SBSCameraSwitchVisibilityAlways];
        } else {
            [picker.overlayController setCameraSwitchVisibility:SBSCameraSwitchVisibilityNever];
        }
    }
    NSObject *cameraSwitchButtonMarginsAndSize = [options objectForKey:@"cameraSwitchButtonMarginsAndSize"];
    if (cameraSwitchButtonMarginsAndSize) {
        CGRect buttonRect = [ScanditSDKParameterParser rectFromParameter:cameraSwitchButtonMarginsAndSize];
        [picker.overlayController setCameraSwitchButtonRightMargin:buttonRect.origin.x
                                                         topMargin:buttonRect.origin.y
                                                             width:buttonRect.size.width
                                                            height:buttonRect.size.height];
    }
    NSObject *t8 = [options objectForKey:@"toolBarButtonCaption"];
    if (t8 && [t8 isKindOfClass:[NSString class]]) {
        [picker.overlayController setToolBarButtonCaption:((NSString *) t8)];
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
            
            [picker.overlayController setViewfinderColor:red green:green blue:blue];
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
            
            [picker.overlayController setViewfinderDecodedColor:red green:green blue:blue];
        }
    }
}

+ (CGRect)rectFromParameter:(NSObject *)parameter {
    if (parameter && [parameter isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) parameter) componentsSeparatedByString:@"/"];
        if ([split count] == 4) {
            return CGRectMake([[split objectAtIndex:0] floatValue],
                              [[split objectAtIndex:1] floatValue],
                              [[split objectAtIndex:2] floatValue],
                              [[split objectAtIndex:3] floatValue]);
        }
    }
    return CGRectZero;
}

@end
