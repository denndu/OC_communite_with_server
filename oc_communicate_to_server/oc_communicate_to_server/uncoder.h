//
//  uncoder.h
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uncoder : NSObject

-(NSString*)processApi:(NSString*)api;

-(NSDictionary*)codeDicProcess:(NSDictionary*)input;

-(NSDictionary*)uncodeDicProcess:(NSDictionary*)input;

-(BOOL)responseAuthentic:(id) response;
-(BOOL)resultAuthentic:(id) response;
@end
