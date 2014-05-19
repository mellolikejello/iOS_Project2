//
//  Order.h
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/17/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"

@interface Order : NSObject
@property (nonatomic) NSMutableArray *items;

-(id)init;
-(void)addItem:(OrderItem*)item;
-(NSArray *)getTotals;
+(instancetype)sharedOrder;
@end
