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

#import "MagniteAppLovinInterstitialAdapter.h"
#import "MagniteAppLovinAdapterError.h"
#import "MagniteAppLovinExtras.h"
@import MagniteSDK;

@interface MagniteAppLovinInterstitialAdapter()<MGNIDelegateProtocol>
@property (nonatomic, strong) MGNIAd *interstitialAd;
@property (nonatomic, weak) id<MAInterstitialAdapterDelegate> delegate;
@end

@implementation MagniteAppLovinInterstitialAdapter
- (void)loadInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate {
    MagniteAppLovinExtras *extras = [[MagniteAppLovinExtras alloc] initWithParamsDictionary:parameters.customParameters];
    MGNIAdPreferences *magniteAdPreferences = extras.prefs;
    magniteAdPreferences.placementId = [MagniteAppLovinExtras placementIdFromAdapterResponseParameters:parameters];
    self.delegate = delegate;
    self.interstitialAd = [[MGNIAd alloc] init];
    [self.interstitialAd loadAdWithDelegate:self withAdPreferences:magniteAdPreferences];
}

- (void)showInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate {
    self.delegate = delegate;
    [self.interstitialAd showAd];
}


- (void)didLoadAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didLoadInterstitialAd)]) {
        [self.delegate didLoadInterstitialAd];
    }
}

- (void)failedLoadAd:(MGNIAbstractAd *)ad withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToLoadInterstitialAdWithError:)]) {
        [self.delegate didFailToLoadInterstitialAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void)didShowAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didDisplayInterstitialAd)]) {
        [self.delegate didDisplayInterstitialAd];
    }
}

- (void)failedShowAd:(MGNIAbstractAd *)ad withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToDisplayInterstitialAdWithError:)]) {
        [self.delegate didFailToDisplayInterstitialAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void)didClickAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didClickInterstitialAd)]) {
        [self.delegate didClickInterstitialAd];
    }
}

- (void)didCloseAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didHideInterstitialAd)]) {
        [self.delegate didHideInterstitialAd];
    }
}
@end
