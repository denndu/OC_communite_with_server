//
//  communicaton.m
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import "communicaton.h"

@implementation communicaton


-(instancetype)initWithAPI:(NSString *)api method:(METHOD_TYPE)method params:(NSDictionary *)params
{
    communicaton* object=[[communicaton alloc] init];
    object.api=api;
    object.method=method;
    object.params=params;
    return object;
}

-(void)request{
    uncoder* unc=[[uncoder alloc] init];
    
    NSString* resultApi=[unc codeApiProcess:_api];
    
    NSDictionary* resultParam=[unc codeDicProcess:_params];
    
    _manager=[[AFHTTPRequestOperationManager alloc] init];
    
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    _manager.requestSerializer.timeoutInterval=30;
    
    
    
    [_manager GET:resultApi  parameters:resultParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([unc responseAnthentic:responseObject]) {
            //code
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request failed");
    }];


    
}
@end
