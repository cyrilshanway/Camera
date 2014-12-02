//
//  MainViewController.m
//  Camera
//
//  Created by Cyrilshanway on 2014/11/23.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "Book.h"
#import "ShowBookViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()
{
    NSInteger *arrayNum;
    NSMutableArray *imageArray;
}
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;

@end

@implementation MainViewController
- (NSMutableArray *) imageArray {
 
    if (!imageArray) {
        imageArray = [@[]mutableCopy];
    }
    
    return imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"News";
    
    self.backgroundScrollView.contentSize = CGSizeMake(320.0f, 900.0f);
    
    //設定按鈕顏色
    _sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.3f];
    //設定側邊欄按鈕動作，按下時，顯示側邊欄
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
    
    //設定手勢
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //defaultuser
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultuser = [defaults objectForKey:@"user"];
    
    //parse query
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKey:@"Owner" equalTo:defaultuser];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    
    {
        if (objects) {
            // The find succeeded.
            NSLog(@"successful");
            
            arrayNum = (NSInteger *)objects.count;
            NSLog(@"objects: %ld", objects.count);
            
            
            NSMutableArray *showPicArray = [[NSMutableArray alloc] init];
            
            NSArray *array1 = objects;
            
            for (int i =0; i < array1.count; i++) {
                UIImage *result;
                NSString *imgurlTrans = array1[i][@"imageUrl"];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgurlTrans]];
                
                result = [UIImage imageWithData:data];
                
                [showPicArray addObject:result];
                
                
                //NSLog(@"pic: %@", array1[i][@"imageUrl"]);
                
            }
           imageArray = showPicArray;
            //NSLog(@"%@",array1[0][@"imageUrl"]);
            
            
            
            //顯示畫面
            
             //設定要顯示的書籍數量
             NSMutableArray *imageList = [NSMutableArray arrayWithCapacity:objects.count];
             NSMutableArray *buttonList= [NSMutableArray arrayWithCapacity:objects.count];
             NSMutableArray *imageArray2 = imageArray;
            
             for (int i = 0 ; i < array1.count; i++) {
             
             NSInteger x = 0;
             NSInteger y1 = 80;
             NSInteger y = 0;
             //NSInteger w = 40;
             NSInteger h = 100;//height
             NSInteger g = 40;//間隔
             
             if( (i % 2) == 0) {
             x = 110;
             y = y1 + 0.5*( h + g )* (i-1);
             }
             else {
             x = 250;
             y = y1 + 0.5*( h + g )* (i-2);
             }
             UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 110)];
             [bgView setBackgroundColor:[UIColor lightGrayColor]];
                 bgView.alpha = 0.9f;
             
             UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 110)];
             //[self.backgroundScrollView addSubview:bgView];
             
                 imageView.image =[imageArray2 objectAtIndex:i];
                 
             //[imageView setImage:[UIImage imageNamed:[imageArray2 objectAtIndex:i]]];
             [imageView setContentMode:UIViewContentModeScaleAspectFit];
             [bgView addSubview:imageView];
             //image.backgroundColor = [UIColor grayColor];
             
             
             [imageList addObject:bgView];
             
             UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(x+5, y+5, 90, 110)];
             button.backgroundColor = [UIColor clearColor];
             button.alpha = 0.5;
             [buttonList addObject:button];
             [button setTag:i];
             
                 
            //[button addTarget:self action:@selector(buttonPressed2VC:) forControlEvents:UIControlEventTouchUpInside];
             
             
             [self.backgroundScrollView addSubview:bgView];
             [self.backgroundScrollView addSubview:button];
                 
//                 if (button.tag == 0) {
//                                  [button addTarget:self action:@selector(buttonPressed2VC:) forControlEvents:UIControlEventTouchUpInside];
//                     NSLog(@"ok");
//                 }
             }

            
        } else {
            
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"提醒"
                                        message:@"您的書櫃還沒有書籍，開始新增吧！"
                                        preferredStyle:(UIAlertControllerStyleAlert)];
            
            // 想像成button
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確認"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [alert dismissViewControllerAnimated:YES
                                                                                     completion:nil];
                                                       }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)buttonPressed2VC{
//    
//    [self performSegueWithIdentifier:@"OneBookViewController" sender:self];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
