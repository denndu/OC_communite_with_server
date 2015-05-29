//
//  ViewController.m
//  oc_communicate_to_server
//
//  Created by mac_zj on 15/5/28.
//  Copyright (c) 2015年 mac_zj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendPOST:(id)sender {
    
    AFHTTPRequestOperationManager* manager=[[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
 

    [manager POST:@"http://192.168.3.12:8080/tongbanServer/File/uploadFile" parameters:@{@"file":@""} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:@"/Users/minimac/Desktop/IOSDemo/README.md"] name:@"Readme.md" fileName:@"readme" mimeType:@"objC/NSData"];
        if (error) {
            NSLog(@"formData appendPartWithFileURL  error !%@",error);

    }
    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"upload success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"upload fail");
    }];
}
- (IBAction)sendGET:(id)sender {
    communicaton* Getter=[communicaton initWithAPI:@"test" method:GET params:@{@"param1":@"123"}];
    [Getter setSuccessHandler:^(NSDictionary *response) {
        NSLog(@"get method success");
        
    }];
    [Getter setFailHandler:^(NSDictionary *response) {
        NSLog(@"get method failed");
    }];
    [Getter request];
}

@end
