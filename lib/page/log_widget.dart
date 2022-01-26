import 'package:gp_dio_log/bean/net_options.dart';
import 'package:gp_dio_log/gp_dio_log.dart';
import 'package:flutter/material.dart';

class LogWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogWidget(this.netOptions);

  @override
  _LogWidgetState createState() => _LogWidgetState();
}

class _LogWidgetState extends State<LogWidget>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Request"),
    Tab(text: "Response"),
  ];

  PageController? _pageController;

  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.netOptions.reqOptions!.url!,
          style: theme.textTheme.subtitle1?.copyWith(color: Colors.black87),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1.0,
        iconTheme: theme.iconTheme,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return LogRequestWidget(widget.netOptions);
          } else if (index == 1) {
            return LogResponseWidget(widget.netOptions);
          } else {
            return LogErrorWidget(widget.netOptions);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _bottomTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_outlined), label: 'Request'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_download_outlined), label: 'Response'),
          BottomNavigationBarItem(
              icon: Icon(Icons.error_outline), label: 'Error'),
        ],
      ),
    );
  }

  void _onPageChanged(int value) {
    if (mounted) {
      setState(() {
        currentIndex = value;
      });
    }
  }

  void _bottomTap(int value) {
    _pageController!.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}
