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

#import "MagniteAppLovinAdapter.h"
#import "MagniteAppLovinAdViewAdapter.h"
#import "MagniteAppLovinInterstitialAdapter.h"
#import "MagniteAppLovinRewardedAdapter.h"
#import "MagniteAppLovinNativeAdapter.h"
@import MagniteSDK;

static NSString * const kAdapterVersion = @"0.0.1";

static NSString * const kAppIdKey = @"app_id";

@interface MagniteAppLovinAdapter()<MAAdViewAdapter, MAInterstitialAdapter, MARewardedAdapter, MANativeAdAdapter>
@property (nonatomic, strong) MagniteAppLovinAdViewAdapter *adViewAdapter;
@property (nonatomic, strong) MagniteAppLovinInterstitialAdapter *interstitialAdapter;
@property (nonatomic, strong) MagniteAppLovinRewardedAdapter *rewardedAdapter;
@property (nonatomic, strong) MagniteAppLovinNativeAdapter *nativeAdapter;
@end

@implementation MagniteAppLovinAdapter

- (void)initializeWithParameters:(id<MAAdapterInitializationParameters>)parameters completionHandler:(nonnull void (^)(MAAdapterInitializationStatus, NSString * _Nullable))completionHandler {
    NSString *appID = parameters.serverParameters[kAppIdKey];
    if (appID.length != 0) {
        [self executeBlockOnMainThread:^{
            [self setupMagniteSDKWithAppID:appID parameters:parameters completion:^(NSError *error) {
                if (error) {
                    completionHandler(MAAdapterInitializationStatusInitializedFailure, error.localizedDescription);
                }
                else {
                    completionHandler(MAAdapterInitializationStatusInitializedSuccess, nil);
                }
            }];
        }];
    }
    else {
        completionHandler(MAAdapterInitializationStatusInitializedFailure, @"No Magnite AppID provided yet");
    }
}

- (void)setupMagniteSDKWithAppID:(NSString *)appID parameters:(id<MAAdapterInitializationParameters>)parameters completion:(void(^)(NSError *error))completion {
    MGNISDK *sdk = [MGNISDK sharedInstance];
    [sdk enableMediationModeFor:@"AppLovin" version:kAdapterVersion];
    
    [sdk initializeWithAppID:appID completion:^(NSError *error) {
        if (error) {
            completion(error);
        }
        else {
            [[MGNISDK sharedInstance] handleExtras:^(NSMutableDictionary<NSString *,id> *extras) {
                if (parameters.hasUserConsent) {
                    extras[@"medPas"] = parameters.hasUserConsent;
                }
                
                if (parameters.doNotSell) {
                    extras[@"medCCPA"] = parameters.doNotSell;
                }
            }];
            completion(nil);
        }
    }];
}

- (NSString *)SDKVersion {
    __block NSString *version = nil;
    [self executeBlockOnMainThread:^{
        version = [[MGNISDK sharedInstance] version];
    }];
    return version;
}

- (NSString *)adapterVersion {
    return kAdapterVersion;
}

- (void)destroy {
    self.adViewAdapter = nil;
    self.interstitialAdapter = nil;
    self.rewardedAdapter = nil;
    self.nativeAdapter = nil;
}

#pragma mark - MAAdViewAdapter methods
- (void)loadAdViewAdForParameters:(id<MAAdapterResponseParameters>)parameters adFormat:(MAAdFormat *)adFormat andNotify:(id<MAAdViewAdapterDelegate>)delegate {
    self.adViewAdapter = [[MagniteAppLovinAdViewAdapter alloc] init];
    [self executeBlockOnMainThread:^{
        [self.adViewAdapter loadAdViewAdapterWithParameters:parameters adFormat:adFormat andNotify:delegate];
    }];
}

#pragma mark - MAInterstitialAdapter methods
- (void)loadInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate {
    self.interstitialAdapter = [[MagniteAppLovinInterstitialAdapter alloc] init];
    [self executeBlockOnMainThread:^{
        [self.interstitialAdapter loadInterstitialAdForParameters:parameters andNotify:delegate];
    }];
}

- (void)showInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate {
    [self.interstitialAdapter showInterstitialAdForParameters:parameters andNotify:delegate];
}

#pragma mark - MARewardedAdapter methods
- (void)loadRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate {
    self.rewardedAdapter = [[MagniteAppLovinRewardedAdapter alloc] init];
    [self executeBlockOnMainThread:^{
        [self.rewardedAdapter loadRewardedAdForParameters:parameters andNotify:delegate];
    }];
}

- (void)showRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate {
    [self.rewardedAdapter showRewardedAdForParameters:parameters andNotify:delegate];
}

#pragma mark - MANativeAdAdapter methods
- (void)loadNativeAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MANativeAdAdapterDelegate>)delegate {
    self.nativeAdapter = [[MagniteAppLovinNativeAdapter alloc] init];
    [self executeBlockOnMainThread:^{
        [self.nativeAdapter loadNativeAdForParameters:parameters andNotify:delegate];
    }];
}

#pragma mark - Helper methods
- (void)executeBlockOnMainThread:(void(^)(void))block {
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}
@end
