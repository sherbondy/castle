//
//  PlayerPickerViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "PlayerPickerViewController.h"
#import "Game.h"

// become grouped table view as you learn players' affiliations

@implementation PlayerPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        [self addObserver:self forKeyPath:@"receivingPlayer" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
        _receivingPlayer = nil;
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

- (void)setAction:(PlayerAction)action {
    switch (action) {
        case kDuelAction:
            self.title = @"Duel with?";
            break;
        case kSpyAction:
            self.title = @"Spy on?";
            break;
        case kTradeAction:
            self.title = @"Trade with?";
            break;
        default:
            break;
    }
    _action = action;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Game sharedGame].playerCount - 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *thePlayer = [[Game sharedGame] playerAtIndexPath:indexPath];

    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"PLAYER CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PLAYER CELL"];
    }
    
    cell.textLabel.text = thePlayer.name;
    if (thePlayer.professionRevealed) {
        cell.detailTextLabel.text = [thePlayer.profession objectForKey:@"name"];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@" has %i item%@",
                                     thePlayer.items.count,
                                     ((thePlayer.items.count != 1) ? @"s" : @"")];
    }
    cell.imageView.image = thePlayer.characterImage;

    return cell;
}

- (void)cancel {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)done {
    [[[Game sharedGame] turnVC] performSelector:@selector(setReceivingPlayer:) withObject:_receivingPlayer];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (keyPath == @"currentPlayer"){
        if ([change objectForKey:NSKeyValueChangeNewKey] == nil){
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            NSLog(@"Actual player selected");
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
}

- (void)setReceivingPlayer:(Player *)thePlayer {
    _receivingPlayer = thePlayer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setReceivingPlayer:[[Game sharedGame] playerAtIndexPath:indexPath]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
