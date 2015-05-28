//
//  uncoder.h
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uncoder : NSObject

-(NSString*)codeApiProcess:(NSString*)input;

-(NSDictionary*)codeDicProcess:(NSDictionary*)input;

-(BOOL)responseAnthentic:(id) response;

@end
