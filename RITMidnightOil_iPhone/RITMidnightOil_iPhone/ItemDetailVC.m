//
//  ItemDetailVC.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/16/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ItemDetailVC.h"

@interface ItemDetailVC ()
- (IBAction)changeFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIButton *tall;
@property (weak, nonatomic) IBOutlet UIButton *grande;
@property (weak, nonatomic) IBOutlet UIButton *venti;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *order;
@property (weak, nonatomic) IBOutlet UIPickerView *flavorPicker;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@end

@implementation ItemDetailVC{
    float _priceVal;
    NSString *_size;
    NSString *_selectedFlavor;
    UIColor *ios7BlueColor;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    self.name.text = self.selectedItem.name;
    if(![self.selectedItem.info isEqual: @"No description"]){
        self.description.text = self.selectedItem.info;
    }else{
        self.description.hidden = YES;
    }
    
    if(self.selectedItem.flavors){
        [self.flavorPicker setDelegate:self];
        [self.flavorPicker setDataSource:self];
        self.flavors = self.selectedItem.flavors;
        _selectedFlavor = self.flavors[0];
    } else {
        self.flavorPicker.hidden = YES;
        CGRect tallFrame = self.tall.frame;
        CGRect grandeFrame = self.grande.frame;
        CGRect ventiFrame = self.venti.frame;
        tallFrame.origin.y = 218;
        grandeFrame.origin.y = 202;
        ventiFrame.origin.y = 186;
        self.tall.frame = tallFrame;
        self.grande.frame = grandeFrame;
        self.venti.frame = ventiFrame;
        
    }
    
    self.tall.tag = 10;
    self.grande.tag = 20;
    self.venti.tag = 30;
    
    if(self.selectedItem.prices[@"regular"]){
        self.tall.hidden = YES;
        [self.grande setTitle:@"regular" forState:UIControlStateNormal];
        self.grande.enabled = NO;
        self.grande.hidden = YES;
        self.venti.hidden = YES;
        _size = @"regular";
        _priceVal = [self.selectedItem.prices[_size] floatValue];
        
    } else {
        self.grande.enabled = NO;
        _size = @"grande";
        _priceVal = [self.selectedItem.prices[_size] floatValue];
    }
    self.price.text = [NSString stringWithFormat:@"$%0.2f", _priceVal];
    [self.cancel addTarget:self action:@selector(cancelClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.tall addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.grande addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [self.venti addTarget:self action:@selector(selectSize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    //update favorite button
    if ([self selectedItem].isFavorite) {
        [[self favoriteButton] setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    }
    else {
        [[self favoriteButton] setImage:[UIImage imageNamed:@"nofavorite.png"] forState:UIControlStateNormal];
    }
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

#pragma mark - UIPicker
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.flavors.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.flavors[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedFlavor = self.flavors[row];
}

- (IBAction)order:(id)sender {
    OrderItem *orderItem = [[OrderItem alloc] initWithMenuItem: self.selectedItem];
    orderItem.price = _priceVal;
    orderItem.size = _size;
    if(_selectedFlavor){
        orderItem.flavor = _selectedFlavor;
    }
    [[Order sharedOrder] addItem:orderItem];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)cancelClick:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)selectSize:(UIButton*)sender{
    [self.tall setSelected:NO];
    self.tall.enabled = YES;
    self.venti.enabled = YES;
    self.grande.enabled = YES;
    switch (sender.tag) {
        case 10:
            _size = @"tall";
            self.tall.enabled = NO;
            break;
        case 20:
            _size = @"grande";
            self.grande.enabled = NO;
            break;
        case 30:
            _size = @"venti";
            self.venti.enabled = NO;
            break;
        default:
            break;
    }
    _priceVal = [self.selectedItem selectSize:_size];
    self.price.text = [NSString stringWithFormat:@"$%0.2f", _priceVal];
}

- (IBAction)changeFavorite:(id)sender {
    [self selectedItem].isFavorite = ![self selectedItem].isFavorite;
    NSLog(@"I now equal %d",[self selectedItem].isFavorite);
    
    if ([self selectedItem].isFavorite) {
        [[self favoriteButton] setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    }
    else {
        [[self favoriteButton] setImage:[UIImage imageNamed:@"nofavorite.png"] forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Changed favorite" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Update FavoriteVC" object:self];
}
@end
