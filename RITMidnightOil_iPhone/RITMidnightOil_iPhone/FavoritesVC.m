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
/*#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return [Menu sharedMenu].allCategories.count;
    int tempInt = 0;
    BOOL hasFaves = 0;
    //checks if any section has isFavorite == true, then adds it to an int to return
    for (int i=0; i<[Menu sharedMenu].allCategories.count; i++) {
        NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
    
        for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].organizedItems[i] objectAtIndex:j];
            
            if (tempItem.isFavorite == YES) {
            hasFaves++;
            
            //break;
            }
        }
        
        if (hasFaves > 0) {
            tempInt++;
            hasFaves = 0;
        }
    }
    
    NSLog(@"number of sections = %d",tempInt);
    return tempInt;
    //return*/
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"this is called");
    
    //it will only return what has 1 on the sharedMenu.favorites list (what's favorited?)
    
    int tempInt = 0;
    
    for (int i=0;i<[[Menu sharedMenu].organizedItems count]; i++) {
        NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
        
        for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].organizedItems[i] objectAtIndex:j];
            
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
            //NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
            
            //for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            if (tempItem.isFavorite) {
                [favesArray addObject:tempItem];
            }
            
            //}
        }
        
        
        MenuItem *deletedItem = [favesArray objectAtIndex:indexPath.row];
        //deletedItem.isFavorite = NO;
        
        for (int i=0;i<[[Menu sharedMenu].allItems count]; i++) {
            //NSMutableArray *tempArray = [[Menu sharedMenu].organizedItems objectAtIndex:i];
            
            //for (int j=0; j<tempArray.count; j++) {
            MenuItem *tempItem = [[Menu sharedMenu].allItems objectAtIndex:i];
            
            if (tempItem.name == deletedItem.name) {
                tempItem.isFavorite = NO;
                [self.tableView reloadData];
                //NSLog(@"deleting %@",tempItem.name);
            }
            
            //}
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

//-(void)receivedFavoriteChange{
    //nsuserdefaults once again
//}

 

@end
