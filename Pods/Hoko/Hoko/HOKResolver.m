//
//  HOKResolver.m
//  
//
//  Created by Ivan Bruel on 18/05/15.
//
//

#import "HOKResolver.h"

#import "HOKDevice.h"
#import "HOKLogger.h"
#import "HOKNetworking.h"
#import "HOKNetworkOperation.h"

NSString *const HOKResolverEndpoint = @"smartlinks/resolve";

@interface HOKResolver ()

@property (nonatomic, strong) NSString *token;

@end

@implementation HOKResolver

- (instancetype)initWithToken:(NSString *)token
{
    if (self = [super init]) {
        _token = token;
    }
    return self;
}

- (void)resolveSmartlink:(NSString *)smartlink completion:(void(^)(NSString *deeplink, NSDictionary *metadata, NSError *error))completion
{
    [HOKNetworking postToPath:[HOKNetworkOperation urlFromPath:HOKResolverEndpoint] parameters:[self jsonWithSmartlink:smartlink] token:self.token successBlock:^(id json) {
        NSString *deeplink = [json objectForKey:@"deeplink"];
        NSDictionary *metadata = [json objectForKey:@"metadata"];
        if (completion)
            completion(deeplink, metadata, nil);
    } failedBlock:^(NSError *error) {
        HOKErrorLog(error);
        if (completion)
            completion(nil, nil, error);

    }];
}

- (id)jsonWithSmartlink:(NSString *)smartlink
{
    NSString *smartlinkString = smartlink;
    if ([smartlink isKindOfClass:[NSURL class]])
        smartlinkString = [(NSURL *)smartlink absoluteString];
    return @{@"smartlink": smartlinkString,
             @"uid": [HOKDevice device].uid};
}


@end
