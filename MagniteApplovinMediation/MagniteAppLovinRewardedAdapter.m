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

#import "MagniteAppLovinRewardedAdapter.h"
#import "MagniteAppLovinAdapterError.h"
#import "MagniteAppLovinExtras.h"
@import MagniteSDK;

@interface MagniteAppLovinRewardedAdapter()<MGNIDelegateProtocol>
@property (nonatomic, strong) MGNIAd *rewardedAd;
@property (nonatomic, weak) id<MARewardedAdapterDelegate> delegate;
@end

@implementation MagniteAppLovinRewardedAdapter
- (void)loadRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate {
    MagniteAppLovinExtras *extras = [[MagniteAppLovinExtras alloc] initWithParamsDictionary:parameters.customParameters];
    MGNIAdPreferences *magniteAdPreferences = extras.prefs;
    magniteAdPreferences.placementId = [MagniteAppLovinExtras placementIdFromAdapterResponseParameters:parameters];
    self.delegate = delegate;
    self.rewardedAd = [[MGNIAd alloc] init];
    [self.rewardedAd loadRewardedVideoAdWithDelegate:self withAdPreferences:magniteAdPreferences];
}

- (void)showRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate {
    self.delegate = delegate;
    [self.rewardedAd showAd];
}


- (void)didLoadAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didLoadRewardedAd)]) {
        [self.delegate didLoadRewardedAd];
    }
}

- (void)failedLoadAd:(MGNIAbstractAd *)ad withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToLoadRewardedAdWithError:)]) {
        [self.delegate didFailToLoadRewardedAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void)didShowAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didDisplayRewardedAd)]) {
        [self.delegate didDisplayRewardedAd];
    }
}

- (void)failedShowAd:(MGNIAbstractAd *)ad withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(didFailToDisplayRewardedAdWithError:)]) {
        [self.delegate didFailToDisplayRewardedAdWithError:[MagniteAppLovinAdapterError maAdapterErrorFromMGNIError:error]];
    }
}

- (void)didCompleteVideo:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didRewardUserWithReward:)]) {
        [self.delegate didRewardUserWithReward:[MAReward rewardWithAmount:MAReward.defaultAmount label:MAReward.defaultLabel]];
    }
}

- (void)didClickAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didClickRewardedAd)]) {
        [self.delegate didClickRewardedAd];
    }
}

- (void)didCloseAd:(MGNIAbstractAd *)ad {
    if ([self.delegate respondsToSelector:@selector(didHideRewardedAd)]) {
        [self.delegate didHideRewardedAd];
    }
}
@end
