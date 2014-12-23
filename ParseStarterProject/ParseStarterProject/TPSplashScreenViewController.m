//
//  TPSplashScreenViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/6/14.
//
//

#import <Foundation/Foundation.h>
#import "TPSplashScreenViewController.h"
#import "Masonry.h"
#import "TPUniverse.h"

@implementation TPSplashScreenViewController

//-(void)loadView{
//    [super loadView];
//
//}
-(void)viewDidLoad{

    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[TPUniverse navigationController]setNavigationBarHidden:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.superview);
    }];
    UIImageView* splashImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"demo-splashImage"]];
    [splashImageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:splashImageView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[TPUniverse navigationController]setNavigationBarHidden:NO];
}

@end