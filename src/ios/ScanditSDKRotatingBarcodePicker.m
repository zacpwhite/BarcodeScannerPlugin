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
//  ScanditSDKRotatingBarcodePicker is a utility class in the demo that shows how to make the
//  ScanditSDKBarcodePicker properly change its orientation when the device is rotated by the
//  user. This class is not required when the Scandit SDK is used in portrait mode only.
//

#import "ScanditSDKRotatingBarcodePicker.h"
#import "ScanditSDKOverlayController.h"
#import <objc/runtime.h>

@implementation ScanditSDKRotatingBarcodePicker


- (id)initWithAppKey:(NSString *)scanditSDKAppKey {
    id result = [super initWithAppKey:scanditSDKAppKey];
    
    // As the aspect ratio changes we want to adjust some minor things like the banner. If this is
    // not needed, there is no reason to call anything here. The only important thing is to
    // override shouldAutorotateToInterfaceOrientation.
    [self adjustPickerToOrientation:self.interfaceOrientation];
    
    return result;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    // If this function is overriden, don't forget to call the super view first.
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // Adjust the UI elements.
    [self adjustPickerToOrientation:toInterfaceOrientation];
}

- (void)adjustPickerToOrientation:(UIInterfaceOrientation)orientation {
    // Adjust the offset of the info banner since the dimensions are quite a bit different in
    // portrait and landscape mode.
    CGRect screen = [[UIScreen mainScreen] bounds];
    if (orientation == UIInterfaceOrientationLandscapeLeft
        || orientation == UIInterfaceOrientationLandscapeRight) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [self.overlayController setInfoBannerOffset:- 3 * screen.size.width / 32];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [self.overlayController setInfoBannerOffset:0];
        }
    }
}

- (NSUInteger)supportedInterfaceOrientations {
    // Check the project settings for screen orientation and only allow the specified ones.
    
    NSArray *orientations;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
    } else {
        orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations~ipad"];
    }
    NSUInteger supportedOrientations = 0;
    
    if ([orientations containsObject:@"UIInterfaceOrientationPortrait"]) {
        supportedOrientations = supportedOrientations | (1 << UIInterfaceOrientationPortrait);
    }
    if ([orientations containsObject:@"UIInterfaceOrientationPortraitUpsideDown"]) {
        supportedOrientations = supportedOrientations | (1 << UIInterfaceOrientationPortraitUpsideDown);
    }
    if ([orientations containsObject:@"UIInterfaceOrientationLandscapeLeft"]) {
        supportedOrientations = supportedOrientations | (1 << UIInterfaceOrientationLandscapeLeft);
    }
    if ([orientations containsObject:@"UIInterfaceOrientationLandscapeRight"]) {
        supportedOrientations = supportedOrientations | (1 << UIInterfaceOrientationLandscapeRight);
    }
    
    return supportedOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Check the project settings for screen orientation and only allow rotation to the specified 
    // ones.
    
    NSArray *orientations;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
    } else {
        orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations~ipad"];
    }
    
    if ([orientations containsObject:@"UIInterfaceOrientationPortrait"]
            && interfaceOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    } else if ([orientations containsObject:@"UIInterfaceOrientationPortraitUpsideDown"]
               && interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else if ([orientations containsObject:@"UIInterfaceOrientationLandscapeLeft"]
               && interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    } else if ([orientations containsObject:@"UIInterfaceOrientationLandscapeRight"]
               && interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    } else {
        return NO;
    }
}

@end
