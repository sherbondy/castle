//
//  DescriptionViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "DescriptionViewController.h"

@implementation DescriptionViewController

- (id)init {
    self = [super init];
    if (self){
        _descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.view.height)];
        _descriptionView.autoresizingMask = UIViewAutoresizingAll;
        _descriptionView.editable = NO;
        [_descriptionView setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:_descriptionView];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];

    }
    return self;
}

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description {
    self = [self init];
    if (self){
        self.title = title;
        self.description = description;
    }
    return self;
}

- (void)setDescription:(NSString *)description {
    _description = description;
    _descriptionView.text = description;
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

- (void)done {
    [self dismissModalViewControllerAnimated:YES];
}

@end
