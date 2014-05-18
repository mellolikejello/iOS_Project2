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
    if(dict[@"prices"]){
        self.prices = dict[@"prices"];
        // grande by default
        _selectedPrice = self.prices[@"grande"] ? [self.prices[@"grande"] doubleValue]: 0.00;
    }
    else if(dict[@"price"]){
        self.prices = nil;
        _selectedPrice = [dict[@"prices"] doubleValue];
    }
    else{
        NSLog(@"super exception in MenuItem -- check, %@", self.name);
    }
    self.isOrdered = false;
    _options = [NSMutableArray array];
    if(self.prices){
        
    }
    return self;
}

@end
