//
//  AppDelegate.m
//  RITMidnightOil_iPhone
//
//  Created by Student on 5/8/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "AppDelegate.h"
#import "Menu.h"
#import "MenuItem.h"

NSString * const kMENU_DATA = @"midnightOilMenu";

@implementation AppDelegate

-(void)loadData{
    NSDictionary *jsonDict;
    NSString *path = [[NSBundle mainBundle]pathForResource:kMENU_DATA ofType:@"js"];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    
    if(error){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error parsing JSON data" message:[error description] delegate:self cancelButtonTitle:nil otherButtonTitles:@":(", nil];
        [alert show];
    }else{
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if(error){
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error parsing JSON data" message:[error description] delegate:self cancelButtonTitle:nil otherButtonTitles:@":(", nil];
            [alert show];
        }else{
            NSArray *items = jsonDict[@"categories"];
            NSMutableArray *allMenuItems = [[NSMutableArray alloc] init];
            NSMutableArray *allCategories = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < items.count; i++) {
                if([items objectAtIndex:i][@"category"]){
                    // we have a header
                    //NSLog(@"%@",items[i][@"category"]);
                    [allCategories addObject:items[i][@"category"]];
                    NSMutableArray *organizedItems = [NSMutableArray array];
                    
                    NSArray *subItems = [items objectAtIndex:i][@"items"];
                    for(int j=0; j<subItems.count;j++){
                        MenuItem *subItem = [[MenuItem alloc] initWithDictionary: [subItems objectAtIndex:j]];
                        [organizedItems addObject:subItem];
                        [allMenuItems addObject:subItem];
                        
                        
                    }
                    [[Menu sharedMenu].organizedItems addObject:organizedItems];
                }
                else{
                    MenuItem *item = [[MenuItem alloc] initWithDictionary: [items objectAtIndex:i]];
                    [allMenuItems addObject:item];
                    
                    
                }
            }
            
            [Menu sharedMenu].allCategories = allCategories;
            [Menu sharedMenu].allItems = allMenuItems;
        }
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self loadData];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
