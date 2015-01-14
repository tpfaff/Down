//
//  TPAddFriendsTableViewController.m
//  Down
//
//  Created by Tyler Pfaff on 1/12/15.
//
//

#import "TPAddFriendsTableViewController.h"
#import "TPConstants.h"
#import <Parse/Parse.h>
#import <Masonry/Masonry.h>

@interface TPAddFriendsTableViewController ()
@end

@implementation TPAddFriendsTableViewController

NSString* nameQuery;
NSArray* dataSource;
static NSString* reuseIdentifier;
NSMutableArray* cellStates;
PFQuery* friendQuery;

-(id)initWithClassName:(NSString *)className{
//    textKey property
//    imageKey property
//    placeholderImage property
//    loadingViewEnabled property
//    pullToRefreshEnabled property
//    paginationEnabled property
//    objectsPerPage property
//    loading property
    if(self=[super initWithClassName:className]){
        self.searchBar=[[UISearchBar alloc]init];
        self.searchBar.delegate=self;
        self.textKey=kTPUserName;
        self.imageKey=kTPProfileImage;
        self.loadingViewEnabled=NO;
        self.pullToRefreshEnabled=YES;
        self.objectsPerPage=10;
        self.loading=NO;
        reuseIdentifier=@"friendCell";
        cellStates=[[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    self.tableView.tableHeaderView=self.searchBar;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchBar).with.offset(self.searchBar.mas_height);
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.objects.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if(!cell){
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    }
//    if([cellStates objectAtIndex:indexPath.row]){
//        cell.accessoryType=UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType=UITableViewCellAccessoryNone;
//    }
//    cell.textLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:kTPUserName];
//    return cell;
//}


//-(PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
//       PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if(!cell){
//               cell=[[PFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//            }
//    cell.textLabel.text=[object valueForKey:kTPUserName];
//    PFFile* file=[object valueForKey:kTPProfileImage];
//    if([object valueForKey:kTPProfileImage]){
//    cell.imageView.image=[object valueForKey:kTPProfileImage];
//    }
//    return cell;
//}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
        
}

-(PFQuery *)queryForTable{
    return friendQuery;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)objectsDidLoad:(NSError *)error{
//    //dataSource=self.objects;
//   // [self.tableView reloadData];
//    [super objectsDidLoad:error];
//    NSLog(@"%@",error);
//}

-(void)queryForFriends{
   // friendQuery=[[PFQuery alloc]initWithClassName:@"_User"];
    [self loadObjects];
    // !!!: This search is slow for large datasets
    
//    [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(objects.count>0){
//            [self updateTableAfterSearchWithResults:objects];
//        }
//    }];
}

-(void)updateTableAfterSearchWithResults:(NSArray*)results{
    dataSource=results;
    [self.tableView reloadData];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(!friendQuery){
        friendQuery=[[PFQuery alloc]initWithClassName:self.parseClassName];
    }else{
        [friendQuery cancel];
    }
    [friendQuery whereKey:kTPUserName containsString:searchText];
    
    [self loadObjects];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    dataSource=nil;
}

@end
