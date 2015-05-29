//
//  communicaton.m
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import "communicaton.h"

@interface communicaton()

@property(nonatomic,strong)NSString* cacheKey;

@property(nonatomic)BOOL needCache;

@property(nonatomic)BOOL cacheExist;

@end

@implementation communicaton


+(instancetype)initWithAPI:(NSString *)api method:(METHOD_TYPE)method params:(NSDictionary *)params
{
    communicaton* object=[[communicaton alloc] init];
    object.api=api;
    object.method=method;
    object.params=params;
    
    
    /*
     cachekey计算
     */
    object.cacheKey=api;
    
    object.needCache=true;
    object.cacheExist=false;
    
    for (NSString* item in NO_CACHE_API) {
        if ([api isEqualToString:item]) {
            object.needCache=false;
            break;
        }
    }
    if (object.needCache) {
        TMCache* cache=[TMCache sharedCache];
        if([cache objectForKey:api]){
            object.cacheExist=true;
    
            NSLog(@"需要cache，Cache存在");
        }else{
            object.cacheExist=false;
            NSLog(@"需要cache,cache不存在");
        }
    }
    

    
    return object;
}
+(void)setNoCacheApis:(NSMutableArray *)array{
    
    NO_CACHE_API=[NSMutableArray arrayWithArray:array];
}

-(void)request{
    
    if (_cacheExist) {
        
        TMCache* cache=[TMCache sharedCache];
        
        NSDictionary* response=[cache valueForKey:_cacheKey];
        uncoder* unc=[[uncoder alloc] init];
#warning 目前默认缓存的也是密文
        NSDictionary* resultResponse=[unc uncodeDicProcess:response];
        _successHandler(resultResponse);
    }
    
#pragma mark 构建请求体
    
    _manager=[[AFHTTPRequestOperationManager alloc] init];
    
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    _manager.requestSerializer.timeoutInterval=30;
    
    
    
    uncoder* unc=[[uncoder alloc] init];
    
    NSString* resultApi=[unc processApi:_api];
    
    NSDictionary* resultParam=[unc codeDicProcess:_params];
    
    
    
    
    void(^success)(AFHTTPRequestOperation*,id)=^(AFHTTPRequestOperation *operation,id responseObject){
        if ([unc responseAnthentic:responseObject]) {
            _successHandler(responseObject);
        }
    };
    
    void(^failure)(AFHTTPRequestOperation *operation, NSError *error)=^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSLog(@"request failed");
    };
    
    
    
    [_manager GET:resultApi  parameters:resultParam success:success failure:failure];


    
}
@end
