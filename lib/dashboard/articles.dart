import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/ad_state.dart';
import 'package:collection/collection.dart';

class Articles extends StatefulWidget {
  final Function pageNumberSelector;

  Articles(this.pageNumberSelector);

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final _data = [];
  var loadingNextRound = false;
  var isMoreDataAvailable = true;
  var lastElement;
  final ScrollController _scrollController = ScrollController();

  final FirebaseFirestore _firestore = Fire().getInstance;

  getInitialRound() {
    setState(() {
      loadingNextRound = true;
    });
    try {
      _firestore.collection('articles').limit(3).get().then((qs) {
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        print(qs);
        lastElement = qs.docs.last;
        for (var element in qs.docs) {
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          _data.add(element.data());
          print(_data);
        }
        if (qs.docs.length < 3) {
          isMoreDataAvailable = false;
        }
        setState(() {
          _data;
          isMoreDataAvailable;
          loadingNextRound = false;
        });
      });
    } catch (error) {
      print('error');
    }
  }

  getMoreData() async {
    if (loadingNextRound == false) {
      setState(() {
        loadingNextRound = true;
      });
      try {
        _firestore
            .collection('articles')
            .startAfterDocument(lastElement)
            .limit(3)
            .get()
            .then((qs) {
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
          print(qs);
          lastElement = qs.docs.last;
          for (var element in qs.docs) {
            print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
            _data.add(element.data());
            print(_data);
          }
          if (qs.docs.length < 3) {
            isMoreDataAvailable = false;
          }
          setState(() {
            _data;
            isMoreDataAvailable;
            loadingNextRound = false;
          });
        });
      } catch (error) {
        print('error');
      }
    }
  }

  Future getDownloadLink(profileLocation) async {
    // var resizedImage = profileLocation;
    // List<String> temp = resizedImage.split('.');
    // temp.insert(temp.length - 1, '_100x100.');
    // temp.join();
    var _downloadUrl =
        await FirebaseStorage.instance.ref(profileLocation).getDownloadURL();
    return _downloadUrl;
  }

  Future<void> _makeRequestInside(url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          print('Can\'t lauch now !!!');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'GECA',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    letterSpacing: 1,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                content: Text(
                  'Failed to connect ...',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 2,
                          color: Color.fromRGBO(255, 255, 255, 1),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.network_check,
                    size: 32,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                Text(
                  'No Internet',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    border: Border.all(
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 2,
                      color: Color.fromRGBO(255, 255, 255, 1),
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
  }

  myGrid(value) {
    return GestureDetector(
      onTap: () {
        _makeRequestInside(value['source']);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 15, 8, 0),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              offset: Offset(0, 0.5),
              blurRadius: 1.5,
            ),
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                color: Colors.amber,
                child: Center(
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^C1 ${snapshot.data}');
                      if (snapshot.data != null) {
                        print(
                            '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^C2 ${snapshot.data}');
                        return CachedNetworkImage(
                          imageUrl: '${snapshot.data}',
                          imageBuilder: (context, imageProvider) {
                            return Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            );
                          },
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/not_found.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 15,
                        ),
                      );
                    },
                    future:
                        getDownloadLink(value['img']), // From global variables
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(5, 8, 5, 5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value['category'],
                    style: TextStyle(
                      color: Color.fromRGBO(230, 0, 0, 1),
                      fontSize: 16,
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Signika',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getInitialRound();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent -
              MediaQuery.of(context).size.height * 2))) {
        if (isMoreDataAvailable) {
          getMoreData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return widget.pageNumberSelector(1);
      },
      child: Container(
        // color: Color.fromRGBO(255, 255, 255, 1),
        color: Color.fromRGBO(0, 255, 255, 0.25),
        child: ListView(
          controller: _scrollController,
          children: [
            ..._data.mapIndexed((index, element) {
              print(element);
              return myGrid(element);
            }),
            loadingNextRound
                ? Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 50,
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  )
                : Container(),
            isMoreDataAvailable == false
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      '---  ***  ---',
                      style: TextStyle(
                          fontFamily: 'Signika', fontWeight: FontWeight.w700),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
