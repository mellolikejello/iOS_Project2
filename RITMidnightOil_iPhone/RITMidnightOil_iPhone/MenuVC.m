
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
    NSMutableArray *collapseBools;
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
    //NSUSERDEFAULTS - if a user has saved data...(this must be called before the view loads)
    //Author: Julienne Ablay
    //Summary: The app looks for 'favoritesData' in its userdefaults.if there is none, nothing happens
    //          If there is stored nsuserdefaults, the NSArray of booleans stored will overwrite
    //          the isFavorite booleans in each MenuItem
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSArray *objectArray = [prefs arrayForKey:@"favoritesData"];
    if(objectArray != nil){
        NSLog(@"Object is still here!");
        NSArray *favesDefaults = [prefs objectForKey:@"favoritesData"];
        
        
        //Go through this array and the array of MenuItems
        
        for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {
            
            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            tempItem.isFavorite = [favesDefaults[i] boolValue];
            
        }
    } else {
        NSLog(@"no user defaults found");
    }
    
    [super viewDidLoad];

    // these booleans check if a section is collapsed or not
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
    return [Menu sharedMenu].allCategories.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [Menu sharedMenu].allCategories[section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //Author: Julienne Ablay
    //this creates a custom header with a button to collapse/expand different sections
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
    [button addTarget:self action:@selector(headerTapped:) forControlEvents:UIControlEventTouchDown];
    [myView addSubview:button];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    
    return myView;
}

//Author: Julienne Ablay
//Summary: Called when a user taps the button at the header. This collapses/expands the chosen section
- (void)headerTapped:(UIButton*)sender {
    
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
    NSArray *itemArray = [Menu sharedMenu].organizedItems[indexPath.section];
    MenuItem *item = itemArray[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
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

// Send details for selected item
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ItemDetailVC *destinationController = (ItemDetailVC*)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *itemArray = [Menu sharedMenu].organizedItems[indexPath.section];
    MenuItem *item = itemArray[indexPath.row];
    destinationController.selectedItem = item;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedFavoriteChange)
                                                 name:@"Changed favorite"
                                               object:nil];
}

//Author: Julienne Ablay
//Summary: sets up nsuserdefaults to save favorites data whenever a user adds/deletes favorites
- (void)receivedFavoriteChange{
    //use this to save to nsuserdefaults whenever someone changes this
    
    //first create an array of BOOLs from allItems
    //0 == not favorited
    //1 == favorited
    
    NSMutableArray *favesArray = [NSMutableArray array];
    
    for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {
        MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
        
        if (tempItem.isFavorite) {
            [favesArray addObject:[NSNumber numberWithBool:YES]];
        } else {
            [favesArray addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    //now saving the favesArray to nsuserdefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:favesArray forKey:@"favoritesData"];
    [userDefaults synchronize];
    
    NSLog(@"data saved");
}


@end
