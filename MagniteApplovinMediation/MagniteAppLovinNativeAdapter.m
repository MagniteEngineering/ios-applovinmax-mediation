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

#import "MagniteAppLovinNativeAdapter.h"
#import "MagniteAppLovinAdapterError.h"
#import "MagniteAppLovinNativeAd.h"
#import "MagniteAppLovinExtras.h"
@import MagniteSDK;

@interface MagniteAppLovinNativeAdapter()<MGNIDelegateProtocol>
@property (nonatomic, strong) MGNINativeAd *nativeAd;
@property (nonatomic, strong) MagniteAppLovinNativeAd *adapterNativeAd;
@property (nonatomic, weak) id<MANativeAdAdapterDelegate> delegate;
@end

@implementation MagniteAppLovinNativeAdapter
- (void)loadNativeAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MANativeAdAdapterDelegate>)delegate {
    MagniteAppLovinExtras *extras = [[MagniteAppLovinExtras alloc] initWithParamsDictionary:parameters.customParameters];
    self.delegate = delegate;
    self.nativeAd = [[MGNINativeAd alloc] init];
    MGNINativeAdPreferences *nativeAdPrefs = extras.prefs;
    nativeAdPrefs.adsNumber = 1;
    nativeAdPrefs.autoBitmapDownload = YES;
    nativeAdPrefs.placementId = [MagniteAppLovinExtras placementIdFromAdapterResponseParameters:parameters];
    [self.nativeAd loadAdWithDelegate:self withNativeAdPreferences:nativeAdPrefs];
}

- (MANativeAd *)maNativeAdFromMGNINativeAdDetails:(MGNINativeAdDetails *)nativeAdDetails {
    if (nativeAdDetails) {
        self.adapterNativeAd = [[MagniteAppLovinNativeAd alloc] initWithMGNINativeAdDetails:nativeAdDetails];
        return self.adapterNativeAd;
    }
    return nil;
}

- (void)didLoadAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didLoadAdForNativeAd:withExtraInfo:)]) {
        [self.delegate didLoadAdForNativeAd:[self maNativeAdFromMGNINativeAdDetails:self.nativeAd.adsDetails.firstObject] withExtraInfo:nil];
    }
}

- (void)failedLoadAd:(MGNIAbstractAd *)ad withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToLoadNativeAdWithError:)]) {
        [self.delegate didFailToLoadNativeAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void)didSendImpressionForNativeAdDetails:(MGNINativeAdDetails *)nativeAdDetails {
    if ([self.delegate respondsToSelector:@selector(didDisplayNativeAdWithExtraInfo:)]) {
        [self.delegate didDisplayNativeAdWithExtraInfo:nil];
    }
}

- (void)didClickNativeAdDetails:(MGNINativeAdDetails *)nativeAdDetails {
    if ([self.delegate respondsToSelector:@selector(didClickNativeAd)]) {
        [self.delegate didClickNativeAd];
    }
}

@end
