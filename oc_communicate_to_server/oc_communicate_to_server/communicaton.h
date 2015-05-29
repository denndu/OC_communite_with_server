//
//  communicaton.h
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

    

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "uncoder.h"
#import "TMCache.h"
typedef  NS_ENUM(NSInteger, METHOD_TYPE) {
    POST=1,
    GET=2,
};

static NSMutableArray* NO_CACHE_API;

@interface communicaton : NSObject

@property(strong,nonatomic)NSString* api;

@property(nonatomic)METHOD_TYPE method;

@property(nonatomic,strong)NSDictionary* params;

@property(strong,nonatomic)void(^successHandler)(NSDictionary* response);

@property(strong,nonatomic)void(^failHandler)(NSDictionary* response);

@property(strong,nonatomic)AFHTTPRequestOperationManager* manager;

+(instancetype)initWithAPI:(NSString*)api
                    method:(METHOD_TYPE)method
                    params:(NSDictionary*)params;
+(void)setNoCacheApis:(NSMutableArray*) array;
-(void)setSuccessHandler:(void (^)(NSDictionary* response))successHandler;
-(void)setFailHandler:(void (^)(NSDictionary* response))failHandler;
-(void)request;



@end
