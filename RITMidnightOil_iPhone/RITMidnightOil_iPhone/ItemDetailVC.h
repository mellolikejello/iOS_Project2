//
//  ItemDetailVC.h
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/16/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "OrderItem.h"
#import "Order.h"

@interface ItemDetailVC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic) MenuItem *selectedItem;
@property(nonatomic)NSArray *flavors;
@end
