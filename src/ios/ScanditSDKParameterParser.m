//
//  ScanditSDKParameterParser.m
//  Hello World
//
//  Created by Moritz Hartmeier on 10/06/15.
//
//

#import "ScanditSDKParameterParser.h"


@implementation ScanditSDKParameterParser

+ (NSArray *)floatsFromParameter:(NSObject *)parameter {
    NSMutableArray *result = [NSMutableArray array];
    
    if (parameter && [parameter isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) parameter) componentsSeparatedByString:@"/"];
        if ([split count] == 4) {
            int xOffset = [[split objectAtIndex:0] floatValue];
            int yOffset = [[split objectAtIndex:1] floatValue];
            int landscapeXOffset = [[split objectAtIndex:2] intValue];
            int landscapeYOffset = [[split objectAtIndex:3] intValue];
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
