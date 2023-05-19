import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geca/content/failedToLoad.dart';
import 'package:geca/navigation/myHome.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final Function pageNumberSelector;
  final String url, logo;
  MyWebView(this.pageNumberSelector, this.url, this.logo);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  var shouldPushReloadPage = true;
  var shouldDisplayExpandedDraggable = false;
  var floatingX = 15.0;
  var floatingY = 15.0;
  var shouldProgressIndicatorDisplay = true;
  var resetLoadingState = true;
  late double currentProgressValue = 0.0;
  late WebViewController _controller;

  Future<bool> _backPressed() async {
    var temp = await _controller.canGoBack();
    if (temp) {
      _controller.goBack();
    } else {
      // widget.pageNumberSelector(1);
      if (widget.url != 'https://www.ecajmer.ac.in') {
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    }
    // Back functions were listed above
    // return is necessary So,
    // This return FALSE is used to just stop app from closing
    // TRUE is used to close app
    return false;
  }

  // refresh Page
  _refreshNow() async {
    _controller.reload();
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> _makeRequest2(url) async {
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print('Can\'t lauch now !!!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _makeRequest(url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          print('Can\'t lauch now !!!');
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('GECA'),
            content: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.network_check,
                    size: 32,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Text(
                  'No Internet connection .',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    letterSpacing: 1,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Stack(
          children: [
            Column(
              children: [
                (shouldProgressIndicatorDisplay == true)
                    ? Center(
                        child: LinearProgressIndicator(
                          value: currentProgressValue,
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    allowsInlineMediaPlayback: true,
                    // onWebResourceError: (){},
                    onWebResourceError: (webResourceError) {
                      if (shouldPushReloadPage == true) {
                        shouldPushReloadPage = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FailedToLoad(_refreshNow),
                          ),
                        );
                      }
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        shouldPushReloadPage = true;
                      });
                    },
                    onWebViewCreated: (WebViewController controller) {
                      // setState(() {
                      //   shouldProgressIndicatorDisplay = false;
                      // });
                      _controller = controller;
                    },
                    gestureNavigationEnabled: true,
                    // onPageStarted: (start) {
                    //   setState(() {
                    //     shouldProgressIndicatorDisplay = true;
                    //   });
                    // },
                    // onPageFinished: (finish) {
                    //   setState(() {
                    //     shouldProgressIndicatorDisplay = false;
                    //   });
                    // },
                    onProgress: (progress) async {
                      // if (resetLoadingState == true) {
                      //   shouldProgressIndicatorDisplay = true;
                      //   resetLoadingState = false;
                      // }
                      print('......................$progress');
                      print(currentProgressValue);
                      setState(() {
                        // shouldProgressIndicatorDisplay = false;
                        currentProgressValue = progress / 100;
                        // print('......................$progress');
                      });
                      // if (progress == 100) {
                      //   setState(() {
                      //     shouldProgressIndicatorDisplay = false;
                      //     resetLoadingState = true;
                      //   });
                      // }
                      var _currentUrl = await _controller.currentUrl();
                      if (_currentUrl!.contains('.pdf')) {
                        _makeRequest(_currentUrl);
                      }
                      if (progress > 0) {
                        if (_currentUrl.contains('youtube.com') ||
                            _currentUrl.contains('youtu.be')) {
                          _makeRequest2(Uri.encodeFull(_currentUrl));
                          // This reload is used to reload back and cancel youtube loading
                          _controller.reload();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            (widget.logo != '')
                ? Positioned(
                    width: 60,
                    height: (shouldDisplayExpandedDraggable == true) ? 210 : 60,
                    // In this Appbar height is fixed at 52
                    bottom: (floatingY != 15)
                        ? (MediaQuery.of(context).size.height - 60 - floatingY)
                        : 15,
                    right: (floatingX != 15)
                        ? (MediaQuery.of(context).size.width - 60 - floatingX)
                        : 15,
                    child: Draggable(
                      feedback: FloatingActionButton(
                          child: Icon(Icons.dashboard_rounded),
                          onPressed: () {}),
                      childWhenDragging: Container(),
                      // onDragStarted: () {
                      //   setState(() {
                      //     shouldDisplayExpandedDraggable = false;
                      //     floatingY -= 120;
                      //   });
                      // },
                      onDragUpdate: (_) {
                        if (shouldDisplayExpandedDraggable == true) {
                          setState(() {
                            shouldDisplayExpandedDraggable = false;
                            floatingY -= 120;
                          });
                        }
                      },
                      onDragEnd: (details) {
                        print('${details.offset.dx} ${details.offset.dy}');
                        setState(() {
                          floatingX = details.offset.dx;
                          floatingY = details.offset.dy;
                        });
                      },
                      child: Column(
                        children: [
                          (shouldDisplayExpandedDraggable == true)
                              ? GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          Color.fromRGBO(36, 14, 123, 1),
                                      child: Icon(
                                        Icons.open_in_browser_rounded,
                                        size: 34,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    var url = await _controller.currentUrl();
                                    var connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());
                                    if (connectivityResult !=
                                        ConnectivityResult.none) {
                                      try {
                                        if (await canLaunchUrl(
                                            Uri.parse(url!))) {
                                          await launchUrl(Uri.parse(url));
                                        } else {
                                          print('Can\'t lauch now !!!');
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            // title: Text('GECA'),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: Icon(
                                                    Icons.network_check,
                                                    size: 32,
                                                    color: Color.fromRGBO(
                                                        255, 0, 0, 1),
                                                  ),
                                                ),
                                                Text(
                                                  'No Internet',
                                                  style: TextStyle(
                                                    fontFamily: 'Signika',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    letterSpacing: 1,
                                                    color: Color.fromRGBO(
                                                        36, 14, 123, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              GestureDetector(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 0, 0, 1),
                                                    border: Border.all(
                                                      color: Color.fromRGBO(
                                                          255, 0, 0, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    'Close',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Signika',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                      letterSpacing: 2,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    // Duration used to stop button flash off before launching in web
                                    Future.delayed(Duration(seconds: 1))
                                        .then((value) {
                                      setState(() {
                                        shouldDisplayExpandedDraggable = false;
                                      });
                                    });
                                  },
                                )
                              : Container(),
                          (shouldDisplayExpandedDraggable == true)
                              ? GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          Color.fromRGBO(36, 14, 123, 1),
                                      child: Icon(
                                        Icons.home_rounded,
                                        size: 34,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    widget.pageNumberSelector(1);
                                  },
                                )
                              : Container(),
                          (shouldDisplayExpandedDraggable == false)
                              ? GestureDetector(
                                  child: Container(
                                    // alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                      backgroundImage: AssetImage(widget.logo),
                                      // child: Image(
                                      //   image: AssetImage(widget.logo),
                                      // ),
                                    ),
                                  ),
                                  onTap: () {
                                    // This website should change if other sites will use
                                    if ((widget.url ==
                                        'https://www.ecajmer.ac.in')) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyHome(),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  onDoubleTap: () async {
                                    var connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());
                                    if (connectivityResult !=
                                        ConnectivityResult.none) {
                                      _controller.reload();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            // title: Text('GECA'),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: Icon(
                                                    Icons.network_check,
                                                    size: 32,
                                                    color: Color.fromRGBO(
                                                        255, 0, 0, 1),
                                                  ),
                                                ),
                                                Text(
                                                  'No Internet',
                                                  style: TextStyle(
                                                    fontFamily: 'Signika',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    letterSpacing: 1,
                                                    color: Color.fromRGBO(
                                                        36, 14, 123, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              GestureDetector(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 0, 0, 1),
                                                    border: Border.all(
                                                      color: Color.fromRGBO(
                                                          255, 0, 0, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    'Close',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Signika',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                      letterSpacing: 2,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      shouldDisplayExpandedDraggable = true;
                                    });
                                  },
                                )
                              : GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          Color.fromRGBO(255, 0, 0, 1),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 34,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      shouldDisplayExpandedDraggable = false;
                                    });
                                  },
                                ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                // child: Container(
                //   color: Color.fromRGBO(0, 0, 0, 0.2),
                //   height: MediaQuery.of(context).size.height * 0.25,
                //   width: 500,
                // ),
                // onTapDown: (_) {
                //   print("................");
                // },
                onVerticalDragEnd: (details) {
                  print('vert.............${details.primaryVelocity}');
                  if (details.primaryVelocity! > 3500) {
                    _controller.reload();
                  }
                },
                onVerticalDragUpdate: (details) {
                  // print('vert.............${details.delta}');
                  // print('vert.............${details.globalPosition}');
                  // print('vert.............${details.globalPosition.dy}');
                },
                // onVerticalDragDown: (details) {
                //   print(
                //       'vert.............${details.globalPosition}');
                // },
                onVerticalDragDown: (details) {
                  print('asd ${details.globalPosition}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
