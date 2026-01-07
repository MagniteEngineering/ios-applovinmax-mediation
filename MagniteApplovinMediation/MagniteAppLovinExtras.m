/**
 * Copyright 2025 Magnite, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "MagniteAppLovinExtras.h"
@import MagniteSDK;
@import AppLovinSDK;

static NSString* const kInterstitialMode = @"interstitialmode";
static NSString* const kAdTag = @"adtag";
static NSString* const kMinCPM = @"mincpm";
static NSString* const kNativeImageSize = @"nativeimagesize";
static NSString* const kNativeSecondaryImageSize = @"nativesecondaryimagesize";

static MGNINativeAdBitmapSize stringToBitmapSize(NSString* format) {
    if ([format isEqualToString:@"SIZE72X72"]) {
        return MGNINativeAdBitmapSize72x72;
    } else if ([format isEqualToString:@"SIZE100X100"]) {
        return MGNINativeAdBitmapSize100x100;
    } else if ([format isEqualToString:@"SIZE150X150"]) {
        return MGNINativeAdBitmapSize150x150;
    } else if ([format isEqualToString:@"SIZE340X340"]) {
        return MGNINativeAdBitmapSize340x340;
    } else if ([format isEqualToString:@"SIZE1200X628"]) {
        return MGNINativeAdBitmapSize1200x628;
    }
    return MGNINativeAdBitmapSize150x150;
}

@implementation MagniteAppLovinExtras

- (instancetype)initWithParamsDictionary:(nullable NSDictionary*)params {
    if (self = [self init]) {
        _prefs = [[MGNINativeAdPreferences alloc] init];
        _prefs.adsNumber = 1;
        _prefs.autoBitmapDownload = NO;
        
        [self parseParams:params];
    }
    return self;
}

- (void)parseParams:(nullable NSDictionary *)params {
    if (params == nil) {
        return;
    }
    
    if (params[kInterstitialMode]) {
        self.video = [params[kInterstitialMode] isEqualToString:@"VIDEO"];
    }
    
    if (params[kAdTag]) {
        self.prefs.adTag = params[kAdTag];
    }
    
    if (params[kMinCPM]) {
        self.prefs.minCPM = [params[kMinCPM] doubleValue];
    }
    
    if (params[kNativeImageSize]) {
        self.prefs.primaryImageSize = stringToBitmapSize(params[kNativeImageSize]);
    }
    
    if (params[kNativeSecondaryImageSize]) {
        self.prefs.secondaryImageSize = stringToBitmapSize(params[kNativeSecondaryImageSize]);
    }
}

+ (nullable NSString *)placementIdFromAdapterResponseParameters:(nullable id<MAAdapterResponseParameters>)parameters {
    
    return parameters.adUnitIdentifier.length > 0 ?  parameters.adUnitIdentifier : nil;
}

@end
