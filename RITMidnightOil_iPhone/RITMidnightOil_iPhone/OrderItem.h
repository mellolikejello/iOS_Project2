//
//  OrderItem.h
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/18/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface OrderItem : NSObject

// keep reference to menuItem generated from
@property(nonatomic) MenuItem *menuItem;
@property(nonatomic, copy) NSString *name;
@property(nonatomic) float price;
@property(nonatomic, copy) NSString *flavor;
@property(nonatomic, copy) NSString *size;

-(id)initWithMenuItem:(MenuItem*)item;

@end
