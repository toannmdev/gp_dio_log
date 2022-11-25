import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gp_dio_log/theme/style.dart';

import 'bean/net_options.dart';
import 'gp_dio_log.dart';
import 'page/log_widget.dart';

class HttpLogListWidget extends StatefulWidget {
  const HttpLogListWidget({this.hint, Key? key}) : super(key: key);

  final String? hint;

  @override
  _HttpLogListWidgetState createState() => _HttpLogListWidgetState();
}

class _HttpLogListWidgetState extends State<HttpLogListWidget> {
  LinkedHashMap<String, NetOptions>? logMap;
  List<String>? keys;

  @override
  Widget build(BuildContext context) {
    logMap = LogPoolManager.getInstance()!.logMap;
    keys = LogPoolManager.getInstance()!.keys;
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateOverlayState();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Logs',
          style: theme.textTheme.headline6,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1.0,
        iconTheme: theme.iconTheme.copyWith(color: Colors.black87),
        actions: <Widget>[
          InkWell(
            onTap: _updateOverlayState,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  debugBtnIsShow() ? 'close overlay' : 'open overlay',
                  style: theme.textTheme.caption!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _clearLog,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  'clear',
                  style: theme.textTheme.caption!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: logMap!.length < 1
          ? Center(child: Text('no request log'))
          : Column(
              children: [
                if (widget.hint != null && widget.hint!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.hint!,
                      textAlign: TextAlign.center,
                      style: Style.defText.copyWith(color: Colors.red),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    reverse: false,
                    itemCount: keys!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _LogItem(item: logMap![keys![index]]!),
                  ),
                )
              ],
            ),
    );
  }

  void _updateOverlayState() {
    if (debugBtnIsShow()) {
      dismissDebugBtn();
    } else {
      showDebugBtn(context);
    }
    setState(() {});
  }

  void _clearLog() {
    LogPoolManager.getInstance()!.clear();
    setState(() {});
  }
}

class _LogItem extends StatelessWidget {
  const _LogItem({required this.item, Key? key}) : super(key: key);

  final NetOptions item;

  @override
  Widget build(BuildContext context) {
    var resOpt = item.resOptions;
    var reqOpt = item.reqOptions!;

    var requestTime = getTimeStr1(reqOpt.requestTime!);

    Color? textColor = (item.errOptions != null || resOpt?.statusCode == null)
        ? Colors.red
        : Theme.of(context).textTheme.bodyText1!.color;

    return Card(
      margin: EdgeInsets.all(8),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LogWidget(item)));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${reqOpt.url}', style: Style.defText),
              const SizedBox(height: 8),
              Text(
                '${resOpt?.statusCode}',
                style: Style.defTextBold.copyWith(
                  color: (resOpt?.statusCode ?? 0) == 200
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'requestTime: $requestTime    duration: ${resOpt?.duration ?? 0} ms',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
