//
//  Order.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/17/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "Order.h"

@implementation Order

+(id)sharedOrder{
    static Order *sharedOrder = nil;
    
    if(!sharedOrder){
        sharedOrder = [[self alloc] initPrivate];
    }
    
    return sharedOrder;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[Order sharedOrder]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        self.items = [NSMutableArray array];
    }
    return self;
}

-(void)addItem:(MenuItem*)item{
    [self.items addObject:item];
}

-(NSString*)getTotal{
    // sum total in _items
    return @"$0.00";
}

@end
