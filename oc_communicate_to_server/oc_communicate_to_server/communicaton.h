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
typedef  NS_ENUM(NSInteger, METHOD_TYPE) {
    POST=1,
    GET=2,
};
@interface communicaton : NSObject

@property(strong,nonatomic)NSString* api;

@property(nonatomic)METHOD_TYPE method;

@property(nonatomic,strong)NSDictionary* params;

@property(strong,nonatomic)void(^successHandler)(id response);

@property(strong,nonatomic)void(^failHandler)(id response);

@property(strong,nonatomic)AFHTTPRequestOperationManager* manager;

-(instancetype)initWithAPI:(NSString*)api
                    method:(METHOD_TYPE)method
                    params:(NSDictionary*)params;

-(void)setSuccessHandler:(void (^)(id))successHandler;
-(void)setFailHandler:(void (^)(id))failHandler;
-(void)request;

@end
