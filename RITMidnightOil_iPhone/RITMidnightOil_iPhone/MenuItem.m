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
        _selectedPrice = [dict[@"price"] doubleValue];
    }
    else{
        NSLog(@"Check %@ Menu Item pricing", self.name);
    }
    self.isOrdered = false;
    _options = [NSMutableArray array];
    return self;
}

-(float)getSelectedPrice{
    return _selectedPrice;
}

-(float)selectSize:(NSString*)size{
    if(self.prices[size]){
        _selectedPrice = [self.prices[size] floatValue];
        [_options addObject:size];
        return _selectedPrice;
    }
    return 0.00;
}

-(BOOL)hasOptions{
    return _options != NULL;
}

-(NSString*)getOptions{
    NSMutableString *opt = [NSMutableString string];
    for(int i = 0; i<[_options count];i++){
        [opt insertString:[_options objectAtIndex:i] atIndex:i];
    }
    return (NSString *)opt;
}

@end
