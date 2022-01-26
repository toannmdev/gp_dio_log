import 'package:gp_dio_log/bean/net_options.dart';
import 'package:gp_dio_log/bean/res_options.dart';
import 'package:gp_dio_log/gp_dio_log.dart';
import 'package:gp_dio_log/theme/style.dart';
import 'package:gp_dio_log/widget/json_view.dart';
import 'package:flutter/material.dart';

class LogResponseWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogResponseWidget(this.netOptions);

  @override
  _LogResponseWidgetState createState() => _LogResponseWidgetState();
}

class _LogResponseWidgetState extends State<LogResponseWidget>
    with AutomaticKeepAliveClientMixin {
  bool isShowAll = false;
  double fontSize = 14;

  late ResOptions? response;
  late dynamic json;

  @override
  void initState() {
    response = widget.netOptions.resOptions;
    json = response?.data ?? 'No response';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Text(isShowAll ? 'Shrink all' : 'Expand all'),
            Switch(
              value: isShowAll,
              onChanged: (check) {
                isShowAll = check;

                setState(() {});
              },
            ),
            Expanded(
              child: Slider(
                value: fontSize,
                max: 30,
                min: 1,
                onChanged: (v) {
                  fontSize = v;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Text(
          'Tip: long press a key to copy the value to the clipboard',
          style: TextStyle(
            fontSize: 10,
            color: Colors.red,
          ),
        ),
        _buildJsonView('headers:', response?.headers),
        _buildJsonView('response:', json),
      ],
    ));
  }

  Widget _buildJsonView(key, json) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              copyClipboard(context, toJson(json));
            },
            child: Text('Copy $key'),
          ),
          Text('$key', style: Style.defTextBold),
          JsonView(
            json: json,
            isShowAll: isShowAll,
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
