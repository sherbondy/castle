//
//  CharacterPickerViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "CharacterPickerViewController.h"
#import "Game.h"
#import "JSONKit.h"

@interface CharacterPickerViewController ()

@end

@implementation CharacterPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"characters" ofType:@"json"];
        NSData *characterData = [NSData dataWithContentsOfFile:filePath];
        _characters = [NSMutableArray arrayWithArray:[characterData objectFromJSONData]];
        
        self.title = @"Pick your Character";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(pickNextCharacter:)];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 32)];
    _playerNameLabel.textAlignment = UITextAlignmentCenter;
    _playerNameLabel.autoresizingMask = UIViewAutoresizingHorizontal;
    [self updatePlayerNameLabel];
    [self.view addSubview:_playerNameLabel];
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeCoverFlow;
    _carousel.autoresizingMask = UIViewAutoresizingAll;
    [self.view addSubview:_carousel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)pickNextCharacter:(id)sender {
    NSUInteger characterIndex = _carousel.currentItemIndex;
    NSString *character = [_characters objectAtIndex:characterIndex];
    [[[Game sharedGame] currentPlayer] setCharacter:character];
    [_characters removeObjectAtIndex:characterIndex];
    [_carousel removeItemAtIndex:characterIndex animated:YES];
    [[Game sharedGame] nextTurn];
    [self updatePlayerNameLabel];
    
    if ([Game sharedGame].round != 0){
        NSLog(@"Moving on to next step.");
        [[Game sharedGame] distributeCards];
    }
}

- (void)updatePlayerNameLabel {
    _playerNameLabel.text = [[Game sharedGame] currentPlayer].name;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _characters.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    UIImageView *imageView;
    if (!view) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 270)];
    } else {
        imageView = (UIImageView *)view;
    }
    imageView.image = [Player imageForCharacter:[_characters objectAtIndex:index]];
    
    return imageView;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 150;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
