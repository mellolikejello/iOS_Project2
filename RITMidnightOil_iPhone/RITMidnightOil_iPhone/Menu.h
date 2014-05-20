//
//  Menu.h
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/7/14.
//  Copyright (c) 2014 Student. All rights reserved.
//
// Singleton - contains all menu data

#import <Foundation/Foundation.h>

@interface Menu : NSObject
@property (nonatomic) NSMutableArray *allItems;
@property (nonatomic) NSMutableArray *allCategories;
@property (nonatomic) NSMutableArray *organizedItems; //organizedItems will have an array of items within an array of categories

+(instancetype)sharedMenu;
@end
