
# gp_gp_dio_log
#### HTTP Inspector tool for Dart which can debugging http requests，Currently, DIO based HTTP capture is implemented
#### Of course, you can implement an Interceptor instead of a DiologInterceptor to adapt to other HTTP clients
#### Thank to (https://github.com/flutterplugin/dio_log)

### Add dependency
### 添加依赖
```
dependencies: 
  gp_dio_log : ^4.0.0
```
### [github](https://github.com/toannmdev/gp_dio_log)
```
gp_dio_log:
  git:
    url: https://github.com/toannmdev/gp_dio_log
    ref: master
```
### set interceptor of dio
### 给dio设置监听
```
dio.interceptors.add(DioLogInterceptor());
```
### Add a global hover button on your home page to jump through the log list
```
///display overlay button 显示悬浮按钮
showDebugBtn(context,btnColor: Colors.blue);
///cancel overlay button 取消悬浮按钮
dismissDebugBtn();
///overlay button state of display 悬浮按钮展示状态
debugBtnIsShow()
```
### Or open a log list where you want it to be
``` 
Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HttpLogListWidget(),
    ),
  );  
```
### Other configurable parameters
```
/// Sets the maximum number of entries for logging 设置记录日志的最大条数
LogPoolManager.getInstance().maxCount = 100;
```

### Screenshot 
<img src="https://github.com/toannmdev/gp_dio_log/tree/master/images/log_list.jpg" width="200">      
<img src="https://github.com/toannmdev/gp_dio_log/tree/master/images/images/log_request.jpg" width="200">
<img src="https://github.com/toannmdev/gp_dio_log/tree/master/images/images/log_response.jpg" width="200">

### gif demo 
![gif](https://github.com/toannmdev/gp_dio_log/tree/master/images/images/gp_dio_log_example.gif)
### welcome to add my WeChat,Hand over a friend
<img src="https://github.com/toannmdev/gp_dio_log/tree/master/images/images/wechat.png" width="200">