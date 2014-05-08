//
//  Menu.m
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/7/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "Menu.h"

@implementation Menu

+(id)sharedMenu{
    static Menu *sharedMenu = nil;
    
    if(!sharedMenu){
        sharedMenu = [[self alloc] initPrivate];
    }
    
    return sharedMenu;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[Menu sharedMenu]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        self.allItems = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
