import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gp_dio_log/bean/net_options.dart';
import 'package:gp_dio_log/bean/req_options.dart';
import 'package:gp_dio_log/bean/res_options.dart';
import 'package:gp_dio_log/theme/style.dart';
import 'package:gp_dio_log/utils/copy_clipboard.dart';
import 'package:flutter/material.dart';

import '../gp_dio_log.dart';

class LogRequestWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogRequestWidget(this.netOptions);

  @override
  _LogRequestWidgetState createState() => _LogRequestWidgetState();
}

class _LogRequestWidgetState extends State<LogRequestWidget>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _urlController;
  late TextEditingController _cookieController;
  late TextEditingController _paramController;
  late TextEditingController _bodyController;

  late ReqOptions reqOpt;
  late ResOptions? resOpt;

  late String requestTime;
  late String responseTime;

  final EdgeInsets _defaultPadding = const EdgeInsets.all(4);

  @override
  void initState() {
    _urlController = TextEditingController();
    _cookieController = TextEditingController();
    _paramController = TextEditingController();
    _bodyController = TextEditingController();

    reqOpt = widget.netOptions.reqOptions!;
    resOpt = widget.netOptions.resOptions;

    requestTime = getTimeStr(reqOpt.requestTime!);
    responseTime = getTimeStr(resOpt?.responseTime ?? reqOpt.requestTime!);

    super.initState();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _paramController.dispose();
    _urlController.dispose();
    _cookieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tip: long press a key to copy the value to the clipboard',
              style: TextStyle(fontSize: 10, color: Colors.red),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _copyAll,
                  child: Text('Copy all'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _copyCurl,
                  child: Text('Copy cUrl'),
                  style:ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
            _buildKeyValue('url', reqOpt.url),
            _buildKeyValue('method', reqOpt.method),
            _buildKeyValue('requestTime', requestTime),
            _buildKeyValue('responseTime', responseTime),
            _buildKeyValue('duration', '${resOpt?.duration ?? 0} ms'),
            _buildParam(reqOpt.data),
            _buildJsonView('params', reqOpt.params),
            _buildJsonView('header', reqOpt.headers),
          ],
        ),
      ),
    );
  }

  Widget _buildJsonView(key, json) {
    return Padding(
      padding: _defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ('$key:'),
            style: Style.defTextBold,
          ),
          JsonView(json: json),
        ],
      ),
    );
  }

  Widget _buildKeyValue(k, v) {
    Widget w = _getDefText(k, '${v is String ? '$v' : v?.toString() ?? null}');
    if (k != null) {
      w = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: () {
          copyClipboard(context, v);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: w,
        ),
      );
    }
    return w;
  }

  Padding _getDefText(String k, String v) {
    return Padding(
      padding: _defaultPadding,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: "$k: ", style: Style.defTextBold),
        TextSpan(text: v, style: Style.defText),
      ])),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Map? formDataMap;
  Widget _buildParam(dynamic data) {
    if (data is Map) {
      return _buildJsonView('body', data);
    } else if (data is FormData) {
      formDataMap = Map()
        ..addEntries(data.fields)
        ..addEntries(data.files);
      return _getDefText('formdata', '${map2Json(formDataMap)}');
    } else if (data is String) {
      try {
        var decodedMap = json.decode(data);
        return _buildJsonView('body', decodedMap);
      } catch (e) {
        return Text('body: $data');
      }
    } else {
      return SizedBox();
    }
  }

  String dataFormat(dynamic data) {
    if (data is FormData) {
      return 'formdata:${map2Json(formDataMap)}';
    } else {
      return 'body:${toJson(data)}';
    }
  }

  void _copyAll() {
    copyClipboard(
        context,
        'url: ${reqOpt.url}\nmethod: ${reqOpt.method}\nrequestTime:  $requestTime\nresponseTime: $responseTime\n'
        'duration: ${resOpt?.duration ?? 0}ms\n${dataFormat(reqOpt.data)}'
        '\nparams: ${toJson(reqOpt.params)}\nheader: ${reqOpt.headers}');
  }

  void _copyCurl() {
    copyClipboard(context, reqOpt.cUrl);
  }
}
