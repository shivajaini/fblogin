//
//  FeedViewController.m
//  fblogin
//
//  Created by Shiva Jaini on 6/28/14.
//  Copyright (c) 2014 Shiva Jaini. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *feedItemsView;
-(void)moveInFeedItems;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation FeedViewController

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
    self.feedItemsView.contentSize = CGSizeMake(320, 805);
    self.indicatorView.center = CGPointMake(self.view.center.x, self.view.center.y-80);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self performSelector:@selector(moveInFeedItems) withObject:nil afterDelay:2];
    // Do any additional setup after loading the view from its nib.
}
-(void)moveInFeedItems{
    [self.indicatorView stopAnimating];
    [UIView animateWithDuration:0.2 animations:^{
        self.feedItemsView.center = CGPointMake(self.feedItemsView.center.x, 283);
    }];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
