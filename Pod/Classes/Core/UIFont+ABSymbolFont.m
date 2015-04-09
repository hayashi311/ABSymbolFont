//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+ABSymbolFont.h"
@import CoreText;

@interface ABBundleKey : NSObject
@end
@implementation ABBundleKey
@end

NSString *const kABSymbolFontFamilyName = @"icons";

@implementation UIFont (ABSymbolFont)

+ (instancetype)ab_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kABSymbolFontFamilyName size:size];
    if (!font) {
        NSBundle* bundle = [NSBundle bundleForClass:[ABBundleKey class]];
        NSString *fontPath = [bundle pathForResource:kABSymbolFontFamilyName ofType:@"ttf"];
        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
        CGFontRef cgFont = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(cgFont, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(cgFont);
        CFRelease(provider);
        font = [UIFont fontWithName:kABSymbolFontFamilyName size:size];
    }
    return font;
}

@end
