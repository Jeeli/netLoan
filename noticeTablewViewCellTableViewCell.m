//
//  noticeTablewViewCellTableViewCell.m
//  Sd
//
//  Created by IOS on 15/8/19.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "noticeTablewViewCellTableViewCell.h"
#import "noticeModel.h"

@interface noticeTablewViewCellTableViewCell()<UIWebViewDelegate>
@property(nonatomic,weak) UILabel * contents;
@end
@implementation noticeTablewViewCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return  self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _contents.frame=CGRectMake(10, 0, self.contentView.bounds.size.width-10, self.contentView.bounds.size.height);
}
-(void) setSubviews{
    UILabel * contents=[[UILabel alloc] init];
    [self.contentView addSubview:contents];
    [contents  setNumberOfLines:0];   //numberoflines为0，即不做行数的限制
    //contents.scalesPageToFit =YES;
    _contents=contents;
    [contents setTextColor:Color(96, 96, 96)];
}
- (void)setNoticeModel:(NSMutableDictionary *)noticeModel{
    //[_contents loadHTMLString:noticeModel[@"content"] baseURL:nil];
}
-(void) setName:(NSString *)str{
    _contents.text=str;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    /*CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height+50;
    [webView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.delegate webViewDidFinishLoad:webView];
    if ([webView subviews]) {
        UIScrollView* scrollView = [[webView subviews] objectAtIndex:0];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }*/
    /*if ([webView subviews]) {
     UIScrollView* scrollView = [[webView subviews] objectAtIndex:0];
     [scrollView setContentOffset:CGPointZero animated:YES];
     }*/
}

@end
