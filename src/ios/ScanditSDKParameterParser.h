//
//  ScanditSDKParameterParser.h
//  Hello World
//
//  Created by Moritz Hartmeier on 10/06/15.
//
//

#import <Foundation/Foundation.h>

#import <ScanditBarcodeScanner/ScanditBarcodeScanner.h>


@interface ScanditSDKParameterParser : NSObject

+ (SBSScanSettings *)settingsForOptions:(NSDictionary *)options;

+ (void)updatePickerUI:(SBSBarcodePicker *)picker fromOptions:(NSDictionary *)options;

+ (CGRect)rectFromParameter:(NSObject *)parameter;

@end
