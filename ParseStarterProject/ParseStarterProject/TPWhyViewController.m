//
//  TPWhyViewController.m
//  Down
//
//  Created by Tyler Pfaff on 1/4/15.
//
//

#import "TPWhyViewController.h"
#import "TPConstants.h"
#import "Masonry/Masonry.h"

@interface TPWhyViewController ()

@end


@implementation TPWhyViewController


-(id)init{
    if(self = [super init]){
        self.messageField=[[UITextField alloc]init];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageField];
    [self.messageField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(@kTPNavigationAndStatusBarHeight);
        make.height.equalTo(@200);
    }];
    [self.messageField setBackgroundColor:[UIColor grayColor]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.messageField becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.delegate TPWhyViewController:self textWasEntered:self.messageField.text];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
