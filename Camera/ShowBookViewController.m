//
//  ShowBookViewController.m
//  Camera
//
//  Created by Cyrilshanway on 2014/11/26.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "ShowBookViewController.h"
#import "Book.h"
#import "ScanViewController.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface ShowBookViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *myArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ShowBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    //設定按鈕顏色
    mainVC.sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    //設定側邊欄按鈕動作，按下時，顯示側邊欄
    mainVC.sideBarButton.target = self.revealViewController;
    mainVC.sideBarButton.action = @selector(revealToggle:);
    
    //設定手勢
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    /*
    self.bookImg.image = self.currentDictionary[@"imageAuthor"];
    self.descriptionLabel.text = self.currentDictionary[@"description"];
    self.bookTitle.text = self.currentDictionary[@"title"];
    self.bookAuthor.text = self.currentDictionary[@"name"];
    */
    
    self.bookImg.image = _myBook.imageAuthor;
    self.descriptionLabel.text = _myBook.descriptionBook;
    self.bookTitle.text = _myBook.title;
    self.bookAuthor.text = _myBook.name;

    NSString *publishedString = [NSString stringWithFormat:@"出版社 ： %@", _myBook.bookPublished];
    NSString *pageNumString = [NSString stringWithFormat:@"頁數 : %@",_myBook.pageNum];
    NSString *isbnNumString = [NSString stringWithFormat:@"ISBN : %@",_myBook.ISBNNum];
    
    //myArray = @[_myBook.bookPublished,_myBook.pageNum,_myBook.ISBNNum];
    myArray = @[publishedString, pageNumString,isbnNumString];
    
    
    self.scrollView.contentSize = CGSizeMake(320.0f, 500.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtnPressed:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//datasource delegate(require)
/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
 */
//回傳每個區段要顯示多少列
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//不要做任何運算(畫面會卡住，運算，create)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *requestIdentifier = @"HelloCell";
    static NSString *requestIdentifier2 = @"HelloCell2";
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
            
            //value2-textLabel和detailLabel會連在一起
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:requestIdentifier];
            //cell.textLabel.textColor = [UIColor whiteColor];
            
            //cell.textLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:244.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
            //預設白色，調整tableView的顏色-11/24
            //cell.backgroundColor = [UIColor clearColor];
            //字型
            //cell.textLabel.font = [UIFont systemFontOfSize:20.f];//20.f
            //cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:20.0f];//20.f
            
            
            //
            //cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
            cell.detailTextLabel.font = [UIFont fontWithName:@"apfino" size:14.0f];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier2];
            
            //value2-textLabel和detailLabel會連在一起
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:requestIdentifier2];
            //cell.textLabel.textColor = [UIColor whiteColor];
            
            cell.textLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:244.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
            //預設白色，調整tableView的顏色-11/24
            cell.backgroundColor = [UIColor clearColor];
            //字型
            //cell.textLabel.font = [UIFont systemFontOfSize:20.f];//20.f
            cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:20.0f];//20.f
            
            
            //
            //cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
            cell.detailTextLabel.font = [UIFont fontWithName:@"apfino" size:14.0f];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
            break;
            
        default:
            break;
    }
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
    /*
     if (!cell) {
     //value2-textLabel和detailLabel會連在一起
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:requestIdentifier];
     //cell.textLabel.textColor = [UIColor whiteColor];
     
     cell.textLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:244.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
     //預設白色，調整tableView的顏色-11/24
     cell.backgroundColor = [UIColor clearColor];
     //字型
     //cell.textLabel.font = [UIFont systemFontOfSize:20.f];//20.f
     cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:20.0f];//20.f
     
     
     //
     //cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
     cell.detailTextLabel.font = [UIFont fontWithName:@"apfino" size:14.0f];
     
     cell.selectionStyle = UITableViewCellSelectionStyleGray;
     
     }
     */
    
    /*
    cell.textLabel.text = _myBook.bookPublished;
    cell.textLabel.text = _myBook.pageNum;
    cell.textLabel.text = _myBook.ISBNNum;
    */
    cell.textLabel.text = myArray[indexPath.row];
    
     //cell.textLabel.text = [NSString stringWithFormat:@"頁數 %@",_currentDictionary[@"pageNum"]];
    
    //cell.detailTextLabel.text = detailDataSource[indexPath.row];
    /*
    NSString *title;
    switch (indexPath.section) {
        case 0:
            title = @"Download";
            break;
        case 1:
            title = @"Upload";
            break;
            
        default:
            break;
    }
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 70, 40)];
    [button setTitle:title forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:15.0f];
    
    [button setBackgroundColor:[UIColor clearColor]];
    
    //
    button.tag = indexPath.row;
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.contentView addSubview:button];
    
    //UIView之下可以修改外型
    [button.layer setCornerRadius:10.0f];
    //外框
    [button.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [button.layer setBorderWidth:2.0f];
    */
    /*
     if (indexPath.row == 0) {
     cell.textLabel.text = @"訊息訊息訊息訊息訊息訊息訊息訊息訊息";
     cell.detailTextLabel.text = @"摘要摘要摘要摘要摘要摘要摘要摘要";
     }
     else {
     cell.textLabel.text = @"iOS";
     cell.detailTextLabel.text = @"iOS摘要摘要摘要摘要摘要摘要摘要摘要";
     }
     */
    return cell;
}
/*
-(void)buttonPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSLog(@"You pressed the button %d", btn.tag);
}


//button按到之後
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"you Pressed: %ld %ld", indexPath.section, indexPath.row);
    
}
*/
@end
