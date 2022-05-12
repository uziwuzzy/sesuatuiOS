//
//  ViewController.m
//  SesuatuApp
//
//  Created by Muhammad Fauzi Masykur on 12/05/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startSDKPressed:(id)sender {
    
    SesuatuSDK *sesuatuSDK = [[SesuatuSDK alloc]init];
    [sesuatuSDK fetchDataFromApiWithCompletion:^(BoringResponse * _Nullable response , NSError * _Nullable error) {
        if (response) {
            NSLog(@"responsenya adalah %@", response.activity);
        } else {
            NSLog(@"errornya %@", error);
        }
    }];
}

@end
