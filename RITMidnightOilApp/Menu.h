//
//  Menu.h
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/7/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject
@property (nonatomic) NSMutableArray *allItems;

+(instancetype)sharedMenu;
@end
