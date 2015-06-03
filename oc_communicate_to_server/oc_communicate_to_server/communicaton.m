//
//  communicaton.m
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import "communicaton.h"

@interface communicaton()

@property(strong,nonatomic)AFHTTPRequestOperationManager* manager;

@property(strong,nonatomic)AFHTTPRequestOperation* operation;

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
        if (_successHandler!=nil) {
        _successHandler(resultResponse);
        }
    }
    
#pragma mark 构建请求体
    
    _manager=[[AFHTTPRequestOperationManager alloc] init];
    
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    _manager.requestSerializer.timeoutInterval=30;
    
    
    
    uncoder* unc=[[uncoder alloc] init];
    
    NSString* resultApi=[unc processApi:_api];
    
    NSDictionary* resultParam=[unc codeDicProcess:_params];
    
    
#warning 缺失检查网络连接code
    
    void(^success)(AFHTTPRequestOperation*,id)=^(AFHTTPRequestOperation *operation,id responseObject){
        if ([unc responseAuthentic:responseObject]) {
            if ([unc resultAuthentic:responseObject]) {
                if (_successHandler!=nil) {
                    _successHandler(responseObject);
                }
            }else{
                if (_failHandler!=nil) {
                    _failHandler(responseObject);
                }
            }
        }
    };
    
    void(^failure)(AFHTTPRequestOperation *operation, NSError *error)=^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSLog(@"request failed");
        NSInteger ecode=operation.response.statusCode;
        NSLog(@"The ecode=%ld,error:%@",ecode,error);
    };
    
    
    NSLog(@"final url=%@",resultApi);
    [_manager GET:resultApi  parameters:resultParam success:success failure:failure];

    
}
@end
