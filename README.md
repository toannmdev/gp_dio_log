
# gp_dio_log
#### HTTP Inspector tool for Dart which can debugging http requests，Currently, DIO based HTTP capture is implemented
#### Of course, you can implement an Interceptor instead of a DiologInterceptor to adapt to other HTTP clients
#### Thank to (https://github.com/flutterplugin/dio_log)

### Add dependency
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
```
dio.interceptors.add(DioLogInterceptor());
```
### Add a global hover button on your home page to jump through the log list
```
///display overlay button
showDebugBtn(context,btnColor: Colors.blue);
///cancel overlay button
dismissDebugBtn();
///overlay button state of display
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
/// Sets the maximum number of entries for logging
LogPoolManager.getInstance().maxCount = 100;
```

### Screenshot 
![Log list](https://github.com/toannmdev/gp_dio_log/tree/master/images/log_list.jpg)
![Log request](https://github.com/toannmdev/gp_dio_log/tree/master/images/log_request.jpg)
![Log response](https://github.com/toannmdev/gp_dio_log/tree/master/images/log_response.jpg)


### gif demo 
![Gif](https://github.com/toannmdev/gp_dio_log/tree/master/images/gp_dio_log_example.gif)