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

#import "MagniteAppLovinAdViewAdapter.h"
#import "MagniteAppLovinAdapterError.h"
#import "MagniteAppLovinExtras.h"
@import MagniteSDK;

@interface MagniteAppLovinAdViewAdapter()<MGNIBannerDelegateProtocol>
@property (nonatomic, strong) MGNIBannerView *bannerView;
@property (nonatomic, weak) id<MAAdViewAdapterDelegate> delegate;
@end

@implementation MagniteAppLovinAdViewAdapter

- (void)loadAdViewAdapterWithParameters:(id<MAAdapterResponseParameters>)parameters adFormat:(MAAdFormat *)adFormat andNotify:(id<MAAdViewAdapterDelegate>)delegate {
    MagniteAppLovinExtras *extras = [[MagniteAppLovinExtras alloc] initWithParamsDictionary:parameters.customParameters];
    MGNIAdPreferences *magniteAdPreferences = extras.prefs;
    magniteAdPreferences.placementId = [MagniteAppLovinExtras placementIdFromAdapterResponseParameters:parameters];
    self.delegate = delegate;
    MGNIBannerSize bannerSize;
    if (adFormat == MAAdFormat.banner) {
        bannerSize = MGNIBannerSizePortrait320x50;
    }
    else if (adFormat == MAAdFormat.mrec) {
        bannerSize = MGNIBannerSizeMRec300x250;
    }
    else {
        bannerSize.size = adFormat.size;
        bannerSize.isAuto = NO;
    }
    
    self.bannerView = [[MGNIBannerView alloc] initWithSize:bannerSize origin:CGPointZero adPreferences:magniteAdPreferences withDelegate:self];
    [self.bannerView loadAd];
}


- (void)bannerAdIsReadyToDisplay:(MGNIBannerView *)banner {
    if ([self.delegate respondsToSelector:@selector(didLoadAdForAdView:)]) {
        [self.delegate didLoadAdForAdView:self.bannerView];
    }
}

- (void)didSendImpressionForBannerAd:(MGNIBannerView *)banner {
    if ([self.delegate respondsToSelector:@selector(didDisplayAdViewAd)]) {
        [self.delegate didDisplayAdViewAd];
    }
}

- (void) failedLoadBannerAd:(MGNIBannerView *)banner withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToLoadAdViewAdWithError:)]) {
        [self.delegate didFailToLoadAdViewAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void) didClickBannerAd:(MGNIBannerView *)banner {
    if ([self.delegate respondsToSelector:@selector(didClickAdViewAd)]) {
        [self.delegate didClickAdViewAd];
    }
}

@end
