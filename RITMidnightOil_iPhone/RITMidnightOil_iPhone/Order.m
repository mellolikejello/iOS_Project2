//
//  Order.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/17/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "Order.h"

// NY tax rate
float const kTAX_RATE = 0.08875;

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

// add an item to the order
-(void)addItem:(OrderItem*)item{
    [self.items addObject:item];
}

// get total price for order
// returns array of length 3
// [subtotal, tax, total]
-(NSArray *)getTotals{
    NSMutableArray *totals = [NSMutableArray array];
    float sum = 0;
    for(int i = 0; i<[self.items count]; i++){
        sum += [[self.items objectAtIndex:i] price];
    }
    
    NSString *sTotal = [NSString stringWithFormat:@"$%.2f", sum];
    [totals insertObject:sTotal atIndex:0];
    float taxAmount = sum * kTAX_RATE;
    sTotal = [NSString stringWithFormat:@"$%.2f", taxAmount];
    [totals insertObject:sTotal atIndex:1];
    sum += taxAmount;
    sTotal = [NSString stringWithFormat:@"$%.2f", sum];
    [totals insertObject:sTotal atIndex:2];
    
    return totals;
}

// remove all ordered items
-(void)clearItems{
    [self.items removeAllObjects];
}

@end
