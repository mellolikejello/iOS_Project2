//
//  FavoritesVC.m
//  RITMidnightOil_iPhone
//
//  Created by Student on 5/18/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FavoritesVC.h"

@interface FavoritesVC ()

@end

@implementation FavoritesVC{
   // NSInteger *tempInt;
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
    //Adds an observer for if the favorite button was tapped or a favorite was added/deleted
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ReloadData)
                                                 name:@"Update FavoriteVC"
                                               object:nil];
    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   

}

//Function: ReloadData
//Author: Julienne Ablay
//Summary: This is the function called through NSNotificationCenter that will reload the
//favorites table data if favorites have changed before the view was loaded
-(void)ReloadData{
    NSLog(@"are you reloading data?");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //NSLog(@"this is called");
    
    //it will only return what has a bool of TRUE in 'isFavorites' on the sharedMenu.allItems list (what's favorited?)
    
    int tempInt = 0;
    
    for (int i=0;i<[[Menu sharedMenu].organizedItems count]; i++) {
        NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
        
        for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].organizedItems[i] objectAtIndex:j];
            
            //if this item's isFavorite property is true, a row is added to the section
            if (tempItem.isFavorite) {
                tempInt++;
                NSLog(@"true");
            }
            
        }
    }
    

    NSLog(@"number of rows = %d",tempInt);
    return tempInt;
    //return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    // Similar to numberOfRowsInSection, it checks the allItems to see if an item's isFavorite property
    // is true, and then shows the name in the cell
    
    NSMutableArray *tempArray = [NSMutableArray array];
  
    for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {
        //NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
        
        //for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            if (tempItem.isFavorite) {
                [tempArray addObject:tempItem];
            }
            
        //}
    }
    
    MenuItem *chosenItem = tempArray[indexPath.row];
    
    cell.textLabel.text = chosenItem.name;
    
    //NSLog(@"%@",item);
    //item = [Menu sharedMenu].allItems[indexPath.row];*/
    
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSMutableArray *favesArray = [NSMutableArray array];
        
        for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {

            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            if (tempItem.isFavorite) {
                [favesArray addObject:tempItem];
            }

        }
        
        
        MenuItem *deletedItem = [favesArray objectAtIndex:indexPath.row];

        
        for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {

            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            if (tempItem.name == deletedItem.name) {
                tempItem.isFavorite = NO;
                [self.tableView reloadData];
                //NSLog(@"deleting %@",tempItem.name);
            }

        }
    }

}


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
// This sends the user to the itemDetailVC if they have tapped on a cell
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    NSMutableArray *favesArray = [NSMutableArray array];
    
    for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {
        //NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
        
        //for (int j=0; j<tempArray.count; j++) {
        MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
        
        if (tempItem.isFavorite) {
            [favesArray addObject:tempItem];
        }
        
        //}
    }
    
    ItemDetailVC *destinationController = (ItemDetailVC*)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MenuItem *item = favesArray[indexPath.row];
    destinationController.selectedItem = item;
}



@end
