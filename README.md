
# gp_gp_dio_log
[![pub package](https://img.shields.io/pub/v/dio_log.svg)](https://pub.dev/packages/gp_dio_log)
#### HTTP Inspector tool for Dart which can debugging http requests，Currently, DIO based HTTP capture is implemented
#### Of course, you can implement an Interceptor instead of a DiologInterceptor to adapt to other HTTP clients
#### Thank to (https://github.com/flutterplugin/dio_log)

### Add dependency
### 添加依赖
```
dependencies: 
  gp_dio_log : ^4.0.0
```
### [github](https://github.com/flutterplugin/gp_dio_log)
```
gp_dio_log:
  git:
  url: git@github.com:flutterplugin/gp_dio_log.git
  ref: v2.0.2
```
### set interceptor of dio
### 给dio设置监听
```
dio.interceptors.add(DioLogInterceptor());
```
### Add a global hover button on your home page to jump through the log list
### 在你的主页面添加全局的悬浮按钮，用于跳转日志列表
```
///display overlay button 显示悬浮按钮
showDebugBtn(context,btnColor: Colors.blue);
///cancel overlay button 取消悬浮按钮
dismissDebugBtn();
///overlay button state of display 悬浮按钮展示状态
debugBtnIsShow()
```
### Or open a log list where you want it to be
### 或者在你期望的地方打开日志列表
``` 
Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HttpLogListWidget(),
    ),
  );  
```
### Other configurable parameters
### 其他可设置参数
```
/// Sets the maximum number of entries for logging 设置记录日志的最大条数
LogPoolManager.getInstance().maxCount = 100;
```

### Screenshot 
<img src="https://raw.githubusercontent.com/flutterplugin/gp_dio_log/develop/images/log_list.jpg" width="200">      
<img src="https://raw.githubusercontent.com/flutterplugin/gp_dio_log/develop/images/log_request.jpg" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/gp_dio_log/develop/images/log_response.jpg" width="200">

### gif demo 
![gif](https://raw.githubusercontent.com/flutterplugin/gp_dio_log/develop/images/gp_dio_log_example.gif)
### welcome to add my WeChat,Hand over a friend
<img src="https://raw.githubusercontent.com/flutterplugin/gp_dio_log/develop/images/wechat.png" width="200">