//
//  TPMailBoxViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/6/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "TPConstants.h"

#import "TPMailBoxViewController.h"

@interface TPMailBoxViewController(){}
//@property (strong, nonatomic) IBOutlet UIView *mailView;
@end

@implementation TPMailBoxViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0,0, self.view.superview.frame.size.width, self.view.superview.frame.size.height)];
    [self.view addSubview:self.buttonReceieved];
    [self.view addSubview:self.buttonSent];
    [self.view addSubview:self.imageViewDecorativeFloral];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.buttonReceieved mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY);
        make.width.and.height.equalTo(@250);
    }];
    
    [self.buttonSent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_centerY);
        make.width.and.height.equalTo(@250);
    }];
    
    [self.imageViewDecorativeFloral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:self.buttonReceieved];
    [self.view setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:self.buttonReceieved];
//    [self.buttonReceieved mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_centerY);
//        make.centerX.equalTo(self.view.mas_centerX);
//    }];
    
}
-(id)init{
    if(self=[super init]){
        
        self.buttonReceieved=[[UIButton alloc]init];
        [self.buttonReceieved setBackgroundImage:[UIImage imageNamed:kTPButtonReceived] forState:UIControlStateNormal];
        
        self.buttonSent=[[UIButton alloc]init];
        [self.buttonSent setBackgroundImage:[UIImage imageNamed:kTPButtonSent] forState:UIControlStateNormal];
        
        self.imageViewDecorativeFloral=[[UIImageView alloc]initWithImage:[UIImage imageNamed:kTPflowers] ];
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
    //[self dismissViewControllerAnimated:YES completion:^{
        UITableViewController* outBoxViewController=[[UITableViewController alloc]init];
        [self presentViewController:outBoxViewController animated:YES completion:NULL];
   // }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end

