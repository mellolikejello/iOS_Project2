//
//  OrderVC.m
//  RITMidnightOil_iPhone
//
//  Created by Melody Kelly on 5/18/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "OrderVC.h"

@interface OrderVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *tax;
@property (weak, nonatomic) IBOutlet UIButton *clear;

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
    [self.clear addTarget:self action:@selector(clearOrder:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    //[self.tableView setEditing:YES];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    OrderItem *item = [Order sharedOrder].items[indexPath.row];
    cell.textLabel.text = item.name;
    if(item.flavor){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", item.flavor, item.name];
        if(![item.size isEqual: @"regular"]){
            NSString *first = [item.size substringToIndex:1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@(%@)", item.flavor, item.name, first];
        }
    }
    else if(![item.size isEqual: @"regular"]){
        NSString *first = [item.size substringToIndex:1];
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", item.name, first];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f", item.price];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selected item at %d", indexPath.row);
    [self.tableView setEditing:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [[Order sharedOrder].items removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        [self.tableView setEditing:NO];
        [self updateTotals];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [self updateTotals];
    [super viewWillAppear:animated];
}

-(void)updateTotals{
    NSArray *totals = [[Order sharedOrder] getTotals];
    self.subtotal.text = [totals objectAtIndex:0];
    self.tax.text = [totals objectAtIndex:1];
    self.totalPrice.text = [totals objectAtIndex:2];
}

-(void)clearOrder:(id)sender{
    [[Order sharedOrder] clearItems];
    [self.tableView reloadData];
    [self updateTotals];
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
