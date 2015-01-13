//
//  TPPeopleViewController.m
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#import "TPPeopleViewController.h"
#import "TPConstants.h"

@interface TPPeopleViewController ()

@end

@implementation TPPeopleViewController


-(id)init{
    if(self=[super init]){
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  //e  [self.view setFrame:CGRectMake(0, kTPNavigationAndStatusBarHeight, self.view.frame.size.width, self.view.frame.size.height-kTPNavigationAndStatusBarHeight)];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    
    switch(indexPath.section){
        case 0:
            //[cell setBackgroundColor:[UIColor blueColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"mockPerson"]];
            [cell.textLabel setText:@"Penelope"];
            break;
        case 1:
            [cell setBackgroundColor:[UIColor grayColor]];
            break;
        case 2:
            [cell setBackgroundColor:[UIColor purpleColor]];
            break;
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
