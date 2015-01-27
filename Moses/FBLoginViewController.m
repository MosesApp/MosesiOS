//
//  FBViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-13.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "FBLoginViewController.h"
#import "PageContentViewController.h"
#import "MBProgressHUD.h"
#import "User.h"
#import "FBFriend.h"
#import "Group.h"
#import "Bill.h"

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Clear global and static variables
    _cachedUser = nil;
    [User clearSharedUser];
    [Group clearSharedUserGroups];
    [Bill clearSharedBills];
    [FBFriend clearSharedFBFriends];
    
    _loginFacebookButtonView = [[FBLoginView alloc] init];
    
    // Add facebook permissions and delegate
    _loginFacebookButtonView.delegate = self;
    _loginFacebookButtonView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    // Create the data model
    _pageImages = @[@"screen_login_iphone01.png", @"screen_login_iphone02.png", @"screen_login_iphone03.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.10, self.view.frame.size.height * 0.20, self.view.frame.size.width * 0.80, self.view.frame.size.height * 0.70);
    
    // Determine the size of the facebook button
    _loginFacebookButtonView.frame = CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.70))/2, self.view.frame.size.height * 0.90, self.view.frame.size.width * 0.70, self.view.frame.size.height * 0.50);
    
    // Determine the size of the moses logo
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.60))/2, self.view.frame.size.height * 0.03, self.view.frame.size.width * 0.60, self.view.frame.size.height * 0.16)];
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    imageView.frame = logoView.bounds;
    [logoView addSubview:imageView];
    
    [self addChildViewController:_pageViewController];
    
    [self.view addSubview:_pageViewController.view];
    [self.view addSubview:_loginFacebookButtonView];
    [self.view addSubview:logoView];
    
    [self.pageViewController didMoveToParentViewController:self];
    
}

#pragma mark - Facebook Controller Data Source
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    if (![self isUser:_cachedUser equalToUser:user]) {
                
        // Cache user for second request
        _cachedUser = user;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
        
        _loginFacebookButtonView.hidden = TRUE;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            User *mosesUser = [User sharedUserWithFacebookId:user.objectID
                                                   firstName:user.first_name
                                                    fullName:user.last_name
                                                       email:[user objectForKey:@"email"]
                                                      locale:[user objectForKey:@"locale"]
                                                    timezone:(int)[[user objectForKey:@"timezone"] integerValue]];

            
            // Direct user to the correct view according to server status
            if(mosesUser.dbId){
                
                // Get user related groups
                [Group requestUserGroupRelationWithUserId:mosesUser.dbId];
                
                // Get user related bills
                [Bill requestUserBills:mosesUser.dbId];
                
                // Get friends using Moses
                [FBFriend requestFBFriends];
                
                UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                
                // Destroy Loading animation
                [hud hide:YES];
                [hud removeFromSuperview];
                
                self.view.window.rootViewController = navController;
                //[self presentViewController:navController animated:YES completion:nil];
            }else{
                // Destroy Loading animation
                [hud hide:YES];
                [hud removeFromSuperview];
                
                UIViewController *errorController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConnectFailViewController"];
                
                self.view.window.rootViewController = errorController;
            }

        });
    }
}


- (BOOL)isUser:(id<FBGraphUser>)firstUser equalToUser:(id<FBGraphUser>)secondUser {
    return [firstUser.objectID isEqual:secondUser.objectID] &&
           [firstUser.first_name isEqual:secondUser.first_name] &&
           [[firstUser objectForKey:@"email"] isEqual:[secondUser objectForKey:@"email"]] &&
           [[firstUser objectForKey:@"locale"] isEqual:[secondUser objectForKey:@"locale"]] &&
           [[firstUser objectForKey:@"timezone"] isEqual:[secondUser objectForKey:@"timezone"]];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Page View Controller Data Source
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _pageViewController = nil;
    _loginFacebookButtonView = nil;
    _pageImages = nil;
    _cachedUser = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
