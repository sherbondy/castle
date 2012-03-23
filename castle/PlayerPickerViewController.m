//
//  PlayerPickerViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "PlayerPickerViewController.h"
#import "Game.h"

@interface PlayerPickerViewController ()

@end

@implementation PlayerPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Pick a Player";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Game sharedGame].playerCount - 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *thePlayer = [[[Game sharedGame] playersOmittingCurrent] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"PLAYER CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLAYER CELL"];
    }
    
    cell.textLabel.text = thePlayer.name;
    if (thePlayer.professionRevealed) {
        cell.detailTextLabel.text = [thePlayer.profession objectForKey:@"name"];
    }
    cell.imageView.image = thePlayer.characterImage;
    
    return cell;
}

@end
