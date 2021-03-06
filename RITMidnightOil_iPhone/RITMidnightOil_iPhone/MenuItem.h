//
//  MenuItem.h
//  RITMidnightOilApp
//
//  Created by Melody Kelly on 5/8/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic) NSDictionary *prices;
@property (nonatomic) NSArray *flavors;
@property (nonatomic) BOOL isFavorite;

-(id)initWithDictionary:(NSDictionary*)dict;
-(float)selectSize:(NSString*)size;
@end
