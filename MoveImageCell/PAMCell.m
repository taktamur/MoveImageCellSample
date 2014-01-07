//
//  PAMCell.m
//  MoveImageCell
//
//  Created by tak on 2014/01/07.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "PAMCell.h"

@interface PAMCell()
@property (weak, nonatomic) IBOutlet UIView *clipView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@end


@implementation PAMCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.clipView.clipsToBounds=YES;
        self.photoView.clipsToBounds=NO;
        self.photoView.contentMode=UIViewContentModeScaleAspectFill;
        // ↑nibファイルでもAspectFill を指定してないとだめっぽかった。
    }
    return self;
}

-(void)movePhotoWithTableView:(UITableView *)tableView
{
    // このcellが、tableViewの中央からどれぐらいずれているか計算
    CGFloat gapRatioY = [self gapRatioFromCenterY:tableView];
    
    // clipViewを基準に、photoViewのcenterを移動させる
    CGPoint center = CGPointMake(self.clipView.bounds.size.width/2,
                                 self.clipView.bounds.size.height/2);
    center.y -= gapRatioY * 50;  // ここで割合から、実際にずれるピクセル数に変換。
    self.photoView.center = center;
}

// このCellの中心が、tableViewの中央からどのくらい離れているのかを計算する
// -1.0は、cellの中央がちょうどtableViewの上限に位置する
// 0.0 は、cellの中央がちょうどtableViewの中央に位置する
// 1.0 は、cellの中央がちょうどtableViewの下限に位置する
// はみ出している場合もあるので、-1.0以下や1.0以上になる場合もある。
-(CGFloat)gapRatioFromCenterY:(UITableView *)tableView
{
    // このCellのframeは、tableViewの中での位置になっているので、
    // tableViewのcontentsOffsetから算出する。
    // ここを参考にした http://songofcloud.gluegent.com/2010/04/uitableviewcell.html
    float displayedCenterY = self.center.y - tableView.contentOffset.y;
    float centerDiffY = displayedCenterY - tableView.bounds.size.height/2;
    float gapRatioFromCenterY = centerDiffY*2/tableView.bounds.size.height;
    // centerAspectY は、cellの中央が画面に入っている場合 -1.0 〜1.0の値をとる。
    NSLog( @"displayedCenterY=%f centerDiffY=%f gapRatioFromCenterY=%f",
          displayedCenterY,centerDiffY,gapRatioFromCenterY);
    return gapRatioFromCenterY;
}


@end
