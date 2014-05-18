
//
//  MenuVC.m
//  RITMidnightOil_iPhone
//
//  Created by Student on 5/11/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "MenuVC.h"
#import "MenuItem.h"

@interface MenuVC ()

@end

@implementation MenuVC{
#warning working on collapsible items here
    NSMutableArray *_collapseBools;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    collapseBools = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    for (int i =0; i<[Menu sharedMenu].allCategories.count; i++) {
        [collapseBools addObject:[NSNumber numberWithBool:FALSE]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 3;
    //NSLog(@"%d",[Menu sharedMenu].allCategories.count);
    return [Menu sharedMenu].allCategories.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [Menu sharedMenu].allCategories[section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //Headerview
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 30.0)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *label = [UILabel new];
    
    [myView setBackgroundColor:[UIColor lightGrayColor]];
    
    label.text = [Menu sharedMenu].allCategories[section];
    [label setTextColor:[UIColor blackColor]];
    [label setTintColor:[UIColor blueColor]];
    [label setFrame:CGRectMake(10.0, 4.0, 150.0, 25.0)];
    [myView addSubview:label];
    
    [button setFrame:CGRectMake(285.0, 2.5, 30.0, 25.0)];
    
    if ([collapseBools objectAtIndex:section]== [NSNumber numberWithBool:YES]) {
        NSLog(@"this button should be a minus sign");
        [button setTitle:@"-" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"+" forState:UIControlStateNormal];
    }
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = section;
    button.hidden = NO;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(headerTapped) forControlEvents:UIControlEventTouchDown];
    [myView addSubview:button];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    
    return myView;
}

- (void)headerTapped:(UIButton*)sender {
#warning working on collapsible items when user taps button on header
    
    if ([collapseBools[sender.tag]boolValue] == NO)
        collapseBools[sender.tag] = [NSNumber numberWithBool:YES];
    else
        collapseBools[sender.tag]= [NSNumber numberWithBool:NO];
    
    NSLog(@"now it's %@",collapseBools[sender.tag]);
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return [[Menu sharedMenu].organizedItems objectAtIndex:section].count;
    //NSLog(@"%d",[[[Menu sharedMenu].organizedItems objectAtIndex:section] count]);
    //return [Menu sharedMenu].allItems.count;
    NSLog(@"%@",collapseBools[section]);
    
    if ([collapseBools[section] boolValue] == 0) {
        return 0;
    } else {
        return [[[Menu sharedMenu].organizedItems objectAtIndex:section] count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //[self configureCell:cell atIndexPath:indexPath];
    
    NSArray *itemArray = [Menu sharedMenu].organizedItems[indexPath.section];
    MenuItem *item = itemArray[indexPath.row];
    
    NSLog(@"%@",item);
    //item = [Menu sharedMenu].allItems[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        // TODO: add in when order details available
        //MenuItem *item = [Menu sharedMenu].allItems[indexPath.row];
    NSArray *itemArray = [Menu sharedMenu].organizedItems[indexPath.section];
    MenuItem *item = itemArray[indexPath.row];
    NSLog(@"%@ selected", item.name);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ItemDetailVC *destinationController = (ItemDetailVC*)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *itemArray = [Menu sharedMenu].organizedItems[indexPath.section];
    MenuItem *item = itemArray[indexPath.row];
    destinationController.selectedItem = item;
}


@end
