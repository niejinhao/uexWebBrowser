[TOC]
# 1、简介 [![](http://appcan-download.oss-cn-beijing.aliyuncs.com/%E5%85%AC%E6%B5%8B%2Fgf.png)]()

## 1.1、说明
Android 封装腾讯X5浏览器相关接口

iOS封装WKWebView组件

## 1.2、UI展示
## 1.3、开源源码
插件测试用例与源码下载:[点击]() 插件中心至插件详情页 (插件测试用例与插件源码已经提供)

## 1.4、平台版本支持
本插件的所有API默认支持**Android4.0+**和**iOS8.0+**操作系统.  
有特殊版本要求的API会在文档中额外说明.



# 2、API概览

## 2.1、方法

### 🍭 init 初始化

`uexWebBrowser.init()`

**说明:**

调用uexWebBrowser的其他任何接口前,需调用此接口进行初始化

**参数:**

无

**示例:**

```javascript
uexWebBrowser.init();
```

### 🍭 open 打开BrowserView

`uexWebBrowser.open(param)`

**说明:**

**参数:**


| 参数名称  | 参数类型        | 是否必选 | 说明           |
| ----- | ----------- | ---- | ------------ |
| param | JSON String | 是    | 接口所需数据,形式见下: |

```javascript
var param = {
	x:,
	y:,
	width:,
	height:,
	url:,
}
```

各字段含义如下:

| 字段名称   | 类型     | 是否必选 | 说明                 |
| ------ | ------ | ---- | ------------------ |
| x      | Number | 否    | View左上顶点x坐标，默认为0   |
| y      | Number | 否    | View左上顶点y坐标，默认为0   |
| width  | Number | 否    | View左上顶点y坐标，默认撑满屏幕 |
| height | Number | 否    | View左上顶点y坐标，默认撑满屏幕 |
| url    | String | 否    | 需要加载的url           |


**示例:**

```javascript
var params = {
    w:1080,
    h:600,
    y:500,
    url:"http://www.appcan.cn"
};
uexWebBrowser.open(JSON.stringify(params));
```

### 🍭 close 关闭BrowserView

`uexWebBrowser.close()`

**说明:**

**参数:**


**示例:**

```javascript
uexWebBrowser.close();
```

### 🍭 goBack 后退

`uexWebBrowser.goBack()`

**说明:**

**参数:**

**示例:**

```javascript
uexWebBrowser.goBack();
```



### 🍭 goForward 前进

`uexWebBrowser.goForward()`

**说明:**

**参数:**

**示例:**

```javascript
uexWebBrowser.goForward();
```



### 🍭 reload 重新加载当前网页

`uexWebBrowser.reload()`

**说明:**

**参数:**

**示例:**

```javascript
uexWebBrowser.reload();
```



### 🍭 loadUrl 加载Url

`uexWebBrowser.loadUrl(url)`

**说明:**

**参数:**

| 参数名称 | 参数类型   | 是否必选 | 说明   |
| ---- | ------ | ---- | ---- |
| url  | String | 是    |      |

**示例:**

```javascript
function loadUrl(){
    uexWebBrowser.loadUrl("http://m.hao123.com");
}
```

### 🍭 evaluateJavascript 执行js

`uexWebBrowser.evaluateJavascript(js)`

**说明:**

**参数:**

| 参数名称 | 参数类型   | 是否必选 | 说明   |
| ---- | ------ | ---- | ---- |
| js   | String | 是    |      |

```javascript
uexWebBrowser.evaluateJavascript(js)
```

**示例:**

```javascript
var js="javascript:alert('----------------')";
uexWebBrowser.evaluateJavascript(js);
```




