//
//  TPInboxViewController.m
//  Down
//
//  Created by Tyler Pfaff on 1/31/15.
//
//

#import "TPInboxViewController.h"
#import "TPConstants.h"
#import <Masonry/Masonry.h>
#import <Parse/Parse.h>


@interface TPInboxViewController ()
@property (strong,nonatomic) NSArray* invites;
@end

static NSString* cellID=@"inboxCellID";
@implementation TPInboxViewController

-(id)init{
    if(self=[super init]){
        self.tableView=[[UITableView alloc]init];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
  //  NSString* currentUserObjectId=[[PFUser currentUser]objectId];
    /// !!!: Should probably make each user have an "invited to" field, so we don't have to query ALL the events... yep.
    PFQuery* inviteQuery=[[PFQuery alloc]initWithClassName:KTPParseEvent];
    NSString* currentUserId=[[PFUser currentUser]objectId];
    
    [inviteQuery whereKey:@"Invited" equalTo:[PFUser currentUser]];
    [inviteQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Failed to find invites for user, error: %@",error);
        }else{
            NSLog(@"Hooray!");
       //     NSLog(objects);
            self.invites=objects;
           // [self.invites sort]
            [self.tableView reloadData];
        }
    }];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.invites){
        return self.invites.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[self.tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell=[[UITableViewCell alloc]init];
    }
    
    cell.textLabel.text=[[self.invites objectAtIndex:indexPath.row]objectForKey:@"Message"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
