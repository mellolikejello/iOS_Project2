//
//  ItemDetailVC.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/16/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ItemDetailVC.h"

@interface ItemDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIButton *tall;
@property (weak, nonatomic) IBOutlet UIButton *grande;
@property (weak, nonatomic) IBOutlet UIButton *venti;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *order;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@end

@implementation ItemDetailVC{
    float _priceVal;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.name.text = self.selectedItem.name;
    if(![self.selectedItem.info isEqual: @"No description"]){
        self.description.text = self.selectedItem.info;
    }else{
        self.description.text = @"";
    }
    
    self.tall.tag = 10;
    self.grande.tag = 20;
    self.venti.tag = 30;
    
    if(self.selectedItem.prices[@"regular"]){
        self.tall.hidden = YES;
        [self.grande setTitle:@"regular" forState:UIControlStateNormal];
        self.grande.enabled = NO;
        self.venti.hidden = YES;
        _priceVal = [self.selectedItem.prices[@"regular"] floatValue];
    } else {
        self.grande.enabled = NO;
        _priceVal = [self.selectedItem.prices[@"grande"] floatValue];
    }
    self.price.text = [NSString stringWithFormat:@"$%0.2f", _priceVal];
    [self.cancel addTarget:self action:@selector(cancelClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.tall addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.grande addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.venti addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)order:(id)sender {
    //self.selectedItem.isOrdered = true;
    OrderItem *orderItem = [[OrderItem alloc] initWithMenuItem: self.selectedItem];
    orderItem.price = _priceVal;
    [[Order sharedOrder] addItem:orderItem];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)cancelClick:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)selectSize:(UIButton*)sender{
    NSString *size;
    self.tall.enabled = YES;
    self.venti.enabled = YES;
    self.grande.enabled = YES;
    switch (sender.tag) {
        case 10:
            size = @"tall";
            self.tall.enabled = NO;
            break;
        case 20:
            size = @"grande";
            self.grande.enabled = NO;
            break;
        case 30:
            size = @"venti";
            self.venti.enabled = NO;
            break;
        default:
            break;
    }
    _priceVal = [self.selectedItem selectSize:size];
    self.price.text = [NSString stringWithFormat:@"$%0.2f", _priceVal];
}

@end
