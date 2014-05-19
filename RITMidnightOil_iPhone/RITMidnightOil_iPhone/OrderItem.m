//
//  OrderItem.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/18/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "OrderItem.h"


@implementation OrderItem

-(id)initWithMenuItem:(MenuItem*)item{
    self = [super init];
    if(self){
        self.menuItem = item;
        self.name = item.name;
    }
    return self;
}

@end
