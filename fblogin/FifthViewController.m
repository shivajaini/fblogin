//
//  FifthViewController.m
//  fblogin
//
//  Created by Shiva Jaini on 6/29/14.
//  Copyright (c) 2014 Shiva Jaini. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FifthViewController

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
    self.scrollView.contentSize = CGSizeMake(320, 1100);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
