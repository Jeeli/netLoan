//
//  mytextFiled.m
//  Sd
//
//  Created by IOS on 15/7/16.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "mytextFiled.h"
#import "addConstraints.h"
#import "Login.h"
#import "registers.h"
#import "securityCode.h"
@interface mytextFiled()<setContentDelegate,setGenderDelegate,UITextFieldDelegate>
@property(nonatomic,weak) UITextField *txt_content;
@property(nonatomic,weak) UIImageView * img;
@property(nonatomic,assign) int i;
@end
@implementation mytextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addAry_name:(NSString *)name{
    if (_ary_name==nil) {
        _ary_name=[[NSMutableArray alloc] init];
    }
    [_ary_name addObject:name];
}
- (instancetype)getName{
    return _ary_name[0];
}

- (instancetype)initWithImage:(NSString *)img_name andText:(NSString *)text_name andIsSecureText:(BOOL)IsSecureText andPlaceholder:(NSString *)textPlaceholder andWidth:(NSInteger) width  andImageWidth:(NSInteger) imagewidth andDisplayBorder:(BOOL)isBorder{
    if (self=[super init]) {
        [self makeMytextFiledWithImage:img_name andText:text_name andIsSecureText:IsSecureText andPlaceholder:textPlaceholder andWidth:width andImageWidth:imagewidth andDisplayBorder:isBorder];
    }
      _state=@"down";
       return  self;
}

-(void) makeMytextFiledWithImage:(NSString *)img_name andText:(NSString *)text_name andIsSecureText:(BOOL)IsSecureText andPlaceholder:(NSString *)textPlaceholder andWidth:(NSInteger) width andImageWidth:(NSInteger) imagewidth andDisplayBorder:(BOOL) isBorder{
    UILabel * lb_name=[[UILabel alloc] init];
    UIImageView * img_more=[[UIImageView alloc] init];
    UITextField * txt_content=[[UITextField alloc] init];
    txt_content.delegate=self;
    self.txt_content=txt_content;
    [self addSubview:lb_name];
    [self addSubview:img_more];
    [self addSubview:txt_content];
    _img=img_more;
    img_more.userInteractionEnabled=YES;
 
    //txt_content.clearButtonMode=UITextFieldViewModeAlways;
    txt_content.secureTextEntry=IsSecureText;

    if([textPlaceholder isEqual:@"nil"]) {
        txt_content.text=@"男";
        //设置一键清除按钮是否出现
        txt_content.textAlignment=NSTextAlignmentCenter;
        txt_content.clearButtonMode=UITextFieldViewModeNever;
        txt_content.userInteractionEnabled=NO;
        
    }else{
        //设置空view 让文字和文本框有间距
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
        txt_content.leftView = paddingView;
        txt_content.leftViewMode = UITextFieldViewModeAlways;
        txt_content.clearButtonMode=UITextFieldViewModeAlways;
        txt_content.leftView.contentMode=UIViewContentModeCenter;
    }
    [txt_content setTextColor:[UIColor blackColor]];
    [lb_name setTextColor:Color(84, 123, 114)];
    txt_content.placeholder=textPlaceholder;
    txt_content.returnKeyType=UIReturnKeyDone;
    
    //注册通知
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(change)
                                                 name:UITextFieldTextDidChangeNotification  object:txt_content];*/
    
    //首字母不自动大写
    txt_content.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    if (img_name==nil) {
        if (imagewidth==30) {
            img_more.backgroundColor=[UIColor whiteColor];
        }
    }else{
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        [img_more addGestureRecognizer:tapGesture];
        img_more.image=[UIImage imageNamed:img_name];

    }
    [lb_name setText:text_name];
    
    img_more.translatesAutoresizingMaskIntoConstraints=NO;
    lb_name.translatesAutoresizingMaskIntoConstraints=NO;
    txt_content.translatesAutoresizingMaskIntoConstraints=NO;
    if (isBorder==YES) {
        //设置UITextField的边框的风格
        txt_content.layer.cornerRadius = 5.0f;
         txt_content.borderStyle=UITextBorderStyleRoundedRect;
         txt_content.layer.borderWidth = 0.1f;
         txt_content.layer.borderColor = [[UIColor redColor] CGColor];
    }
    //设置UITextField的文本框背景颜色
    txt_content.backgroundColor=[UIColor whiteColor];
    _textFiledInfo=^(){
        return txt_content.text;
    };
    _setFiledInfo=^(NSString *Str){
        txt_content.text=Str;
    };

    
    securityCode * v_securityCode=[[securityCode alloc] init];
    v_securityCode.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:v_securityCode];

    NSDictionary *metrcs=@{@"lb_name_width":[NSNumber numberWithInteger:width],@"img_more_width":[NSNumber numberWithInteger:imagewidth],@"v_left":[NSNumber numberWithInteger:width+10]};
    UIView * v_bottom=[[UIView alloc] init];
    [self addSubview:v_bottom];
    v_bottom.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary *viewsDic=@{@"lb_name":lb_name,@"img_more":img_more,@"txt_content":txt_content,@"v_securityCode":v_securityCode,@"v_bottom":v_bottom};
    NSMutableArray *arry=[[NSMutableArray alloc] init];
    [arry addObject:@"V:|-0-[txt_content]-0-|"];
    if (imagewidth>100) {
        [arry addObject:@"H:|-0-[lb_name(==lb_name_width)]-0-[txt_content]-0-[v_securityCode(==img_more_width)]-0-|"];
          txt_content.leftViewMode =UITextFieldViewModeNever;
    }else{
        [arry addObject:@"H:|-10-[lb_name(==lb_name_width)]-0-[txt_content]-0-[img_more(==img_more_width)]-0-|"];
    }
    
    if (width==50) {
        if (imagewidth==0) {
            [arry addObject:@"H:|-v_left-[v_bottom]-0-|"];
            [arry addObject:@"V:[v_bottom(==0.5)]-0.5-|"];

        }else{
            [arry addObject:@"H:|-v_left-[v_bottom]-0-|"];
            [arry addObject:@"V:[v_bottom(==0.5)]-0.5-|"];

        }
            v_bottom.backgroundColor=[UIColor redColor];
    }
    //添加约束
    addConstraints *addconstraints=[[addConstraints alloc] init];
    [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self andConstraints:arry];
    self .backgroundColor=[UIColor whiteColor];
}
- (void)setImage:(NSString *)name{
    _img.image=[UIImage imageNamed:name];
}
-(void) setimageState:(NSString *)state{
    _state=state;
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.selectdelegate selectMore];
    if ([_state isEqual:@"down"]) {
         _img.image=[UIImage imageNamed:@"up1"];
        _state=@"up";
    }else{
         _img.image=[UIImage imageNamed:@"down1"];
        _state=@"down";
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    return YES;
}

-(void) setGender:(NSString *) txtGender{
    self.txt_content.text=txtGender;
}

-(void) setContent:(NSString *) txtContent{
    self.txt_content.text=txtContent;
}
-(void)setcolor{
    //self.backgroundColor=Color(227, 227, 227);
}
@end
