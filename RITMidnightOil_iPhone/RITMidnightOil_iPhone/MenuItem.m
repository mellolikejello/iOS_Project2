//
//  MenuItem.m
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/8/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem{
    NSMutableArray *_options;
    double _selectedPrice;
    
}

-(id)initWithDictionary:(NSDictionary *)dict{
    self.name = dict[@"name"] ? dict[@"name"]: @"Unnamed item";
    self.info = dict[@"info"] ? dict[@"info"]: @"No description";
    self.prices = dict[@"prices"] ? dict[@"prices"]: nil;
    self.isOrdered = false;
    return self;
}

@end
