//
//  AppDelegate.m
//  LuaFix
//
//  Created by barryclass on 15/11/25.
//  Copyright © 2015年 barry. All rights reserved.
//

#import "AppDelegate.h"
#import "wax.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *directory = [doc stringByAppendingPathComponent:@"init.lua"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Init" ofType:@"lua"];
    
    NSString *directory2 = [doc stringByAppendingPathComponent:@"ViewController.lua"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"ViewController" ofType:@"lua"];
    
    [manager copyItemAtPath:path  toPath:directory error:nil];
    [manager copyItemAtPath:path2 toPath:directory2 error:nil];
    [self downloadLuaFile3];

    [self downloadLuaFile];
    
    id installManager = [[NSClassFromString(@"InstallManager") alloc] init];
    if ([installManager respondsToSelector:@selector(install)]) {
        [installManager performSelector:@selector(install) withObject:nil];
    }
    
    return YES;
}



- (void)downloadLuaFile {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *directory = [doc stringByAppendingPathComponent:@"SubView.lua"];
        NSURL *url=[NSURL URLWithString:@"https://dn-barry.qbox.me/SubView.lua"];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSError *error=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if([data length]>0)
        {
            NSLog(@"下载成功");
            if([data writeToFile:directory atomically:YES]){
                NSLog(@"保存成功subView");
                NSString *luaFilePath = [[NSString alloc ] initWithFormat:@"%@/%@.lua",doc, @"SubView"];
                //setenv(LUA_PATH, [luaFilePath UTF8String], 0); //差点漏了设置路径
                printf("%s",getenv(LUA_PATH));
                wax_start("init.lua", nil);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"234" object:nil];

            }else {
                NSLog(@"保存失败");
            }
        } else {
            NSLog(@"下载失败，失败原因：%@",error);
        }
    });
}

- (void)downloadLuaFile3 {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *directory = [doc stringByAppendingPathComponent:@"SubView3.lua"];
        NSURL *url=[NSURL URLWithString:@"https://dn-barry.qbox.me/SubView3.lua"];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSError *error=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if([data length]>0)
        {
            NSLog(@"下载成功subView3");
            if([data writeToFile:directory atomically:YES]){
                NSLog(@"保存成功");
                NSString *luaFilePath = [[NSString alloc ] initWithFormat:@"%@/?.lua;",doc];
                setenv(LUA_PATH, [luaFilePath UTF8String], 1); //差点漏了设置路径
                printf("%s",getenv(LUA_PATH));
            }else {
                NSLog(@"保存失败");
            }
        } else {
            NSLog(@"下载失败，失败原因：%@",error);
        }
    });
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
