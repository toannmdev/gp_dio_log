import 'package:gp_dio_log/bean/net_options.dart';
import 'package:flutter/material.dart';

class LogErrorWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogErrorWidget(this.netOptions);

  @override
  _LogErrorWidgetState createState() => _LogErrorWidgetState();
}

class _LogErrorWidgetState extends State<LogErrorWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: double.infinity,
      child: Center(
        child: Text(widget.netOptions.errOptions?.errorMsg ?? 'No error'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
