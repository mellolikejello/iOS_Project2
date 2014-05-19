//
//  OrderVC.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/18/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "OrderVC.h"

float const kTAX_RATE = 0.08875;

@interface OrderVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *tax;

@end

@implementation OrderVC

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
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    //[self.tableView setEditing:YES];
    NSArray *totals = [self getTotals];
    self.subtotal.text = [totals objectAtIndex:0];
    self.tax.text = [totals objectAtIndex:1];
    self.totalPrice.text = [totals objectAtIndex:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Order sharedOrder].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MenuItem *item = [Order sharedOrder].items[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f", [item getSelectedPrice]];
    
    return cell;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(NSArray *)getTotals{
    NSMutableArray *totals = [NSMutableArray array];
    float sum = 0;
    NSMutableArray *items = [Order sharedOrder].items;
    for(int i = 0; i<[items count]; i++){
        sum += [[items objectAtIndex:i] getSelectedPrice];
    }
    
    NSString *sTotal = [NSString stringWithFormat:@"$%.2f", sum];
    [totals insertObject:sTotal atIndex:0];
    float taxAmount = sum * kTAX_RATE;
    sTotal = [NSString stringWithFormat:@"$%.2f", taxAmount];
    [totals insertObject:sTotal atIndex:1];
    sum += taxAmount;
    sTotal = [NSString stringWithFormat:@"$%.2f", sum];
    [totals insertObject:sTotal atIndex:2];
    
    return totals;
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

@end
