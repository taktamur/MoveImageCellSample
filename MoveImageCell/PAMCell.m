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
    }
    return self;
}


@end
