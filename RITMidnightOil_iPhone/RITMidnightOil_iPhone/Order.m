//
//  Order.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/17/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "Order.h"

@implementation Order{
    NSMutableArray *_items;
}

-(id)init{
    self = [super init];
    if(self){
        _items = [NSMutableArray array];
    }
    return self;
}

-(void)addItem:(MenuItem*)item{
    [_items addObject:item];
}

-(NSString*)getTotal{
    // sum total in _items
    return @"$0.00";
}

@end
