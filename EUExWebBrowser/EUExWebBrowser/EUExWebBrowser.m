/**
 *
 *	@file   	: EUExWebBrowser.m  in EUExWebBrowser
 *
 *	@author 	: CeriNo
 * 
 *	@date   	: 2017/4/5
 *
 *	@copyright 	: 2017 The AppCan Open Source Project.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */


#import "EUExWebBrowser.h"
#import "JSON.h"
#import "EUtility.h"
#import <WebKit/WebKit.h>

@interface EUExWebBrowser()
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) NSString *userAgent;
@end

@implementation EUExWebBrowser


- (instancetype)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}



- (void)clean{
    if (self.webview) {
        [self.webview stopLoading];
        [self.webview removeFromSuperview];
        self.webview = nil;
    }
}



- (void)dealloc{
    [self clean];
}


typedef NSNumber * UEX_BOOL;
#define UEX_TRUE @YES
#define UEX_FALSE @NO


static NSNumber * numberArg(id x){
    if ([x isKindOfClass:[NSString class]]) {
        return @([x floatValue]);
    }
    if ([x isKindOfClass:[NSNumber class]]) {
        return x;
    }
    return nil;
};

static NSString * stringArg(id x){
    if ([x isKindOfClass:[NSString class]]) {
        return x;
    }
    if ([x isKindOfClass:[NSNumber class]]) {
        return [x stringValue];
    }
    return nil;
}



#pragma mark - API

- (void)init:(NSMutableArray *)inArguments{
    
    if (inArguments.count == 0) {
        return;
    }
    NSDictionary *info = [inArguments[0] JSONValue];
    if (!info || ![info isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *ua = info[@"userAgent"];
    if (ua && [ua isKindOfClass:[NSString class]]) {
        self.userAgent = ua;
    }
}

- (void)open:(NSMutableArray *)inArguments{
    if (inArguments.count == 0) {
        return;
    }
    NSDictionary *info = [inArguments[0] JSONValue];
    if (!info || ![info isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSNumber *x = numberArg(info[@"x"]) ?: @0;
    NSNumber *y = numberArg(info[@"y"]) ?: @0;
    NSNumber *width = numberArg(info[@"width"]) ?: @(screenSize.width);
    NSNumber *height = numberArg(info[@"height"]) ?: @(screenSize.height);
    CGRect frame = CGRectMake(x.floatValue, y.floatValue, width.floatValue, height.floatValue);
    [self clean];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.allowsInlineMediaPlayback = YES;
    self.webview = [[WKWebView alloc]initWithFrame:frame configuration:config];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9) {
        self.webview.customUserAgent = self.userAgent;
    }
    NSString *urlString = stringArg(info[@"url"]);
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    }
    [EUtility brwView:self.meBrwView addSubview:self.webview];
}


- (void)close:(NSMutableArray *)inArguments{
    [self clean];
}

- (void)goBack:(NSMutableArray *)inArguments{
    [self.webview goBack];
}

- (void)goForward:(NSMutableArray *)inArguments{
    [self.webview goForward];
}

- (UEX_BOOL)canGoBack:(NSMutableArray *)inArguments{
    return self.webview.canGoBack ? UEX_TRUE : UEX_FALSE;
}

- (UEX_BOOL)canGoForward:(NSMutableArray *)inArguments{
    return self.webview.canGoForward ? UEX_TRUE : UEX_FALSE;
}

- (NSString *)getTitle:(NSMutableArray *)inArguments{
    return self.webview.title;
}


- (void)reload:(NSMutableArray *)inArguments{
    [self.webview reload];
}

- (void)loadUrl:(NSMutableArray *)inArguments{
    if(inArguments.count == 0){
        return;
    }
    
    NSString *urlString = stringArg(inArguments[0]);
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)evaluateJavascript:(NSMutableArray *)inArguments{
    if(inArguments.count == 0){
        return;
    }
    NSString *js = stringArg(inArguments[0]);
    static NSString *const kJSPrefix = @"javascript:";
    
    if ([js hasPrefix:kJSPrefix]) {
        js = [js substringFromIndex:kJSPrefix.length];
    }
    [self.webview evaluateJavaScript:js completionHandler:nil];
}





@end
