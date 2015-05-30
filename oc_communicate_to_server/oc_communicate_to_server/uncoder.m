//
//  uncoder.m
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import "uncoder.h"

@implementation uncoder


-(NSDictionary*)codeDicProcess:(NSDictionary *)input{
    NSDictionary* output;
    output=input;
    
    //code process
    return output;
}
-(BOOL)responseAuthentic:(id)response{
        
    return true;
}
-(BOOL)resultAuthentic:(id)response{
    return true;
}
-(NSString*)processApi:(NSString *)api{
    NSString* resultApi;
    resultApi=[NSString stringWithFormat:@"http://192.168.3.11:8080/tongbanServer/%@",api];
    return resultApi;
}
-(NSDictionary*)uncodeDicProcess:(NSDictionary *)input{
    NSDictionary* resultDic;
    resultDic=input;
    return resultDic;
}
@end
