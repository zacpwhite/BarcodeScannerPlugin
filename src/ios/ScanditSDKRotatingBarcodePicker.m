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


@interface ScanditSDKBarcodePicker (extended)
- (id)initWithAppKey:(NSString *)scanditSDKAppKey
cameraFacingPreference:(CameraFacingDirection)facing
  runningOnFramework:(NSString *)usedFramework;
@end

@interface ScanditSDKRotatingBarcodePicker()
@property (nonatomic, strong) NSArray *allowedOrientations;
@property (nonatomic, assign) BOOL didSetSize;
@end



@implementation ScanditSDKRotatingBarcodePicker

@synthesize allowedOrientations;


- (id)initWithAppKey:(NSString *)scanditSDKAppKey
cameraFacingPreference:(CameraFacingDirection)facing
        orientations:(NSArray *)orientations {
    
    if (self = [super initWithAppKey:scanditSDKAppKey
              cameraFacingPreference:facing
                  runningOnFramework:@"phonegap"]) {
		self.allowedOrientations = orientations;
	}
    
    return self;
}

- (void)setPortraitSize:(CGRect)portraitSize {
    _portraitSize = portraitSize;
    self.didSetSize = YES;
}

- (void)setLandscapeSize:(CGRect)landscapeSize {
    _landscapeSize = landscapeSize;
    self.didSetSize = YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (!self.didSetSize) {
        return;
    }
    
    [self adjustSize:0];
}

- (void)adjustSize:(CGFloat)animationDuration {
    [UIView animateWithDuration:animationDuration animations:^{
    
    // Adjust the picker's frame, bounds and the offset of the info banner to fit the new dimensions.
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGRect subviewRect;
    CGRect screenInOrientation;
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        subviewRect = self.landscapeSize;
        screenInOrientation = CGRectMake(0, 0, screen.size.height, screen.size.width);
        
    } else {
        subviewRect = self.portraitSize;
        screenInOrientation = screen;
    }
    
    float widthScale = subviewRect.size.width / screenInOrientation.size.width;
    float heightScale = subviewRect.size.height / screenInOrientation.size.height;
    
    if (widthScale > heightScale) {
        self.size = CGSizeMake(subviewRect.size.width,
                               screenInOrientation.size.height * widthScale);
    } else {
        self.size = CGSizeMake(subviewRect.size.width * screenInOrientation.size.height / screenInOrientation.size.width,
                               subviewRect.size.height);
    }
    
    self.view.bounds = CGRectMake((self.size.width - subviewRect.size.width) / 2,
                                  (self.size.height - subviewRect.size.height) / 2,
                                  subviewRect.size.width, subviewRect.size.height);
    self.view.frame = subviewRect;
    }];
}

- (NSUInteger)supportedInterfaceOrientations {
    NSArray *orientations;
	
	if (!self.allowedOrientations) {
		// Use the orientations from the project settings.
		if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
			orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
		} else {
			orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
		}
	} else {
		// Use the user specified orientations.
		orientations = self.allowedOrientations;
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
    NSArray *orientations;
	
	if (!self.allowedOrientations) {
		// Use the orientations from the project settings.
		if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
			orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
		} else {
			orientations = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UISupportedInterfaceOrientations"];
		}
	} else {
		// Use the user specified orientations.
		orientations = self.allowedOrientations;
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

- (BOOL)shouldAutorotate {
	return YES;
}

@end
