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

#import "MagniteAppLovinAdapterError.h"
@import MagniteSDK;

@implementation MagniteAppLovinAdapterError
+ (MAAdapterError *)maAdapterErrorFromMGNIError:(NSError *)error {
    NSInteger maAdapterErrorCode = 0;
    MAAdapterError *adapterError = nil;
    if (error) {
        switch ((MGNIError)error.code) {
            case MGNIErrorUnexpected:
                maAdapterErrorCode = MAAdapterError.errorCodeUnspecified;
                break;
            case MGNIErrorNoInternetConnection:
                maAdapterErrorCode = MAAdapterError.errorCodeNoConnection;
                break;
            case MGNIErrorInternal:
                maAdapterErrorCode = MAAdapterError.errorCodeInternalError;
                break;
            case MGNIErrorAppIDNotSet:
                maAdapterErrorCode = MAAdapterError.errorCodeNotInitialized;
                break;
            case MGNIErrorInvalidParams:
                maAdapterErrorCode = MAAdapterError.errorCodeInvalidConfiguration;
                break;
            case MGNIErrorAdRules:
                maAdapterErrorCode = MAAdapterError.errorCodeInternalError;
                break;
            case MGNIErrorExpectedAdParamsMissingOrInvalid:
                maAdapterErrorCode = MAAdapterError.errorCodeInternalError;
                break;
            case MGNIErrorAdTypeNotSupported:
                maAdapterErrorCode = MAAdapterError.errorCodeInternalError;
                break;
            case MGNIErrorAdAlreadyDisplayed:
                maAdapterErrorCode = MAAdapterError.errorCodeInternalError;
                break;
            case MGNIErrorAdExpired:
                maAdapterErrorCode = MAAdapterError.errorCodeAdExpired;
                break;
            case MGNIErrorAdNotReady:
                maAdapterErrorCode = MAAdapterError.errorCodeAdNotReady;
                break;
            case MGNIErrorAdIsLoading:
                maAdapterErrorCode = MAAdapterError.errorCodeInvalidLoadState;
                break;
            case MGNIErrorNoContent:
                maAdapterErrorCode = MAAdapterError.errorCodeNoFill;
                break;
            default:
                maAdapterErrorCode = MAAdapterError.errorCodeUnspecified;
                break;
        }
        adapterError = [MAAdapterError errorWithCode:maAdapterErrorCode errorString:error.localizedDescription mediatedNetworkErrorCode:error.code mediatedNetworkErrorMessage:error.localizedDescription];
    }
    else {
        adapterError = [MAAdapterError errorWithCode:MAAdapterError.errorCodeUnspecified errorString:@"MagniteSDK failed to load ad" mediatedNetworkErrorCode:-1 mediatedNetworkErrorMessage:@"Error not set"];
    }
    return adapterError;
}
@end
