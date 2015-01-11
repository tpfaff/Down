//
//  TPWhenViewController.m
//  Down
//
//  Created by Tyler Pfaff on 1/3/15.
//
//

#import "TPWhenViewController.h"
#import "Masonry/Masonry.h"
#import "TPConstants.h"

@interface TPWhenViewController ()

@end

@implementation TPWhenViewController


-(id)init{
    if(self=[super init]){
        self.datePicker=[[UIDatePicker alloc]init];
        self.datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        [self.datePicker addTarget:self action:@selector(userSelectedDate) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self userSelectedDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)userSelectedDate{
    [self.delegate TPWhenViewController:self didSelectDate:[self.datePicker date]];
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
