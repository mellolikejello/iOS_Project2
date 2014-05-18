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

@implementation ItemDetailVC

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
    if(![self.selectedItem.info  isEqual: @"No description"]){
        self.description.text = self.selectedItem.info;
    }else{
        self.description.text = @"";
    }
    if([self.selectedItem.prices count] != 3){
        self.tall.hidden = YES;
        [self.grande setTitle:@"regular" forState:UIControlStateNormal];
        self.venti.hidden = YES;
        self.price.text = [NSString stringWithFormat:@"%@", self.selectedItem.prices[@"regular"]];
    }
    self.price.text = @"";
    [self.order addTarget:self action:@selector(orderClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.cancel addTarget:self action:@selector(cancelClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
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

-(void)orderClick:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)cancelClick:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
