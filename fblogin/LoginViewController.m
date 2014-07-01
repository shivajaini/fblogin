//
//  LoginViewController.m
//  fblogin
//
//  Created by Shiva Jaini on 6/28/14.
//  Copyright (c) 2014 Shiva Jaini. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

@interface LoginViewController ()
- (IBAction)onTapOutside:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *loginFieldsView;
@property (weak, nonatomic) IBOutlet UILabel *signupLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) UITabBarController *tabBarController;
- (IBAction)onemailEdit:(id)sender;
- (IBAction)onpwdEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)onTapLoginButton:(id)sender;
- (void)executePwdcheckafterDelay;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)enableLoginButton;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
   
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    shadow.shadowBlurRadius = 2;
    
    NSDictionary *titleTextAttributes =
    @{
      NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
      NSForegroundColorAttributeName : [UIColor colorWithRed:68 green:98 blue:161 alpha:1],
     // NSShadowAttributeName : shadow
      };
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    FeedViewController *newsfeedview = [[FeedViewController alloc]init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:newsfeedview];
    firstNavigationController.navigationBar.topItem.title = @"News Feed";
    firstNavigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    firstNavigationController.navigationBar.backgroundColor = UIColorFromRGB(0x4462a1);
    [firstNavigationController.navigationBar setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x4462a1)];
    
    UIButton *peopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    peopleButton.frame = CGRectMake(0, 0, 31, 31);
    [peopleButton setImage:[UIImage imageNamed:@"people-icon.png"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] init];
    [rightButton setCustomView:peopleButton];
    firstNavigationController.navigationItem.rightBarButtonItem = rightButton;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 31, 31);
    [searchButton setImage:[UIImage imageNamed:@"search-button.png"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] init];
    [leftButton setCustomView:searchButton];
    firstNavigationController.navigationItem.leftBarButtonItem = leftButton;
    
    firstNavigationController.tabBarItem.title = @"News Feed";
    firstNavigationController.tabBarItem.image = [UIImage imageNamed:@"feed-icon"];
    
    SecondViewController *requestsview = [[SecondViewController alloc]init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:requestsview];
    secondNavigationController.navigationBar.topItem.title = @"Requests";
    secondNavigationController.tabBarItem.title = @"Requests";
    secondNavigationController.tabBarItem.image = [UIImage imageNamed:@"requests-icon"];
    secondNavigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    secondNavigationController.navigationItem.title = @"Requests";
    
    
    ThirdViewController *messagesview = [[ThirdViewController alloc]init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:messagesview];
    thirdNavigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    thirdNavigationController.navigationBar.topItem.title = @"Messages";
    thirdNavigationController.tabBarItem.title = @"Messages";
    thirdNavigationController.tabBarItem.image = [UIImage imageNamed:@"messages-icon"];
    
    FourthViewController *notificationsview = [[FourthViewController alloc]init];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationsview];
    fourthNavigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    fourthNavigationController.navigationBar.topItem.title = @"Notifications";
    fourthNavigationController.tabBarItem.title = @"Notifications";
    fourthNavigationController.tabBarItem.image = [UIImage imageNamed:@"notifications-icon"];
    
    FifthViewController *moreview = [[FifthViewController alloc]init];
    UINavigationController *fifthNavigationController = [[UINavigationController alloc] initWithRootViewController:moreview];
    fifthNavigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    fifthNavigationController.navigationBar.topItem.title = @"Settings";
    fifthNavigationController.tabBarItem.title = @"More";
    fifthNavigationController.tabBarItem.image = [UIImage imageNamed:@"more-icon"];
    
    tabBarController.viewControllers = @[firstNavigationController, secondNavigationController,thirdNavigationController,fourthNavigationController,fifthNavigationController];
    self.tabBarController = tabBarController;
    
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}



- (IBAction)onTapLoginButton:(id)sender {
    [self performSelector:@selector(executePwdcheckafterDelay) withObject:nil afterDelay:2];
    [self.loginButton setImage:[UIImage imageNamed:@"login-button-active"] forState:UIControlStateNormal];
    [self.activityIndicator startAnimating];
    
    
    }
- (void)executePwdcheckafterDelay{
    [self.activityIndicator stopAnimating];
    if([self.passwordTextField.text isEqualToString:@"Password"]){
        // UIViewController *vc = [[FeedViewController alloc] init];
        // UIViewController *vc = [[self.tabBarController alloc]init];
        // vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:self.tabBarController animated:YES completion:nil];
    }
    else{
        [self.loginButton setImage:[UIImage imageNamed:@"login-button"] forState:UIControlStateNormal];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The Password you entered is incorrect. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }

}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginFieldsView.center = CGPointMake(self.loginFieldsView.center.x, self.loginFieldsView.center.y-60);
                         self.signupLabel.center = CGPointMake(self.signupLabel.center.x, self.signupLabel.center.y-160);
                         
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginFieldsView.center = CGPointMake(self.loginFieldsView.center.x, 227);
                         self.signupLabel.center = CGPointMake(self.signupLabel.center.x, 479);
                     }
                     completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.enabled = NO;
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)onTapOutside:(id)sender {
    [self.view endEditing:YES];
    
}


- (IBAction)onemailEdit:(id)sender {
    [self enableLoginButton];
}

- (IBAction)onpwdEdit:(id)sender {
    [self enableLoginButton];
}

-(void)enableLoginButton{
    if(self.emailTextField.text.length >0 && self.passwordTextField.text.length>0){
        self.loginButton.enabled = YES;
    }
    else{
        self.loginButton.enabled = NO;
    
    }
}


@end
