//
//  MenuItem.m
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/8/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(id)initWithDictionary:(NSDictionary *)dict{
    self.name = dict[@"name"] ? dict[@"name"]: @"Unnamed item";
    self.info = dict[@"info"] ? dict[@"info"]: @"No description";
    self.isFavorite = false;
    if(dict[@"prices"]){
        self.prices = dict[@"prices"];
    }
    else{
        NSLog(@"Check %@ Menu Item pricing", self.name);
    }
    if(dict[@"flavors"]){
        self.flavors = dict[@"flavors"];
    }
    return self;
}

// return price of selected size
-(float)selectSize:(NSString*)size{
    if(self.prices[size]){
        return [self.prices[size] floatValue];
    }
    return 0.00;
}

@end
