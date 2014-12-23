//
//  TPMailBoxViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/6/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TPMailBoxViewController.h"
#import "TPUniverse.h"

@interface TPMailBoxViewController(){}
//@property (strong, nonatomic) IBOutlet UIView *mailView;
@end

@implementation TPMailBoxViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //Never gets called!!!
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[TPUniverse navigationController]setNavigationBarHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[TPUniverse navigationController]setNavigationBarHidden:NO];
}
-(id)init{
    if(self=[super init]){
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (IBAction)presentOutboxViewController:(id)sender {
        UITableViewController* outBoxViewController=[[UITableViewController alloc]init];
        [[TPUniverse navigationController]pushViewController:outBoxViewController animated:YES];
        }

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end

