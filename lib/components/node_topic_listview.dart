// node listview
import 'package:flutter/material.dart';
import 'package:flutter_app/model/web/item_node_topic.dart';
import 'package:flutter_app/network/api_web.dart';

class NodeTopicListView extends StatefulWidget {
  final String tabKey;

  NodeTopicListView(this.tabKey);

  @override
  State<StatefulWidget> createState() => new TopicListViewState();
}

class TopicListViewState extends State<NodeTopicListView> with AutomaticKeepAliveClientMixin {
  Future<List<NodeTopicItem>> topicListFuture;

  @override
  void initState() {
    super.initState();
    // 获取数据
    topicListFuture = getTopics();
  }

  Future<List<NodeTopicItem>> getTopics() async {
    return await v2exApi.getNodeTopicsByTabKey(widget.tabKey);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<NodeTopicItem>>(
        future: topicListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new RefreshIndicator(
                child: new Container(
                    color: const Color(0xFFD8D2D1),
                    child: new ListView(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        children: snapshot.data.map((NodeTopicItem topic) {
                          return new TopicItemView(topic);
                        }).toList())),
                onRefresh: _onRefresh);
          } else if (snapshot.hasError) {
            return new Center(
              child: new Text("${snapshot.error}"),
            );
          }

          // By default, show a loading spinner
          return new Center(
            child: new CircularProgressIndicator(),
          );
        });
  }

  //刷新数据,重新设置future就行了
  Future _onRefresh() async {
    setState(() {
      topicListFuture = getTopics();
    });
  }

  @override
  bool get wantKeepAlive => true;
}

/// topic item view
class TopicItemView extends StatelessWidget {
  final NodeTopicItem topic;

  TopicItemView(this.topic);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        // todo 跳转详情页面
        /*Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new TopicDetails(topic)),
        );*/
      },
      child: new Card(
        margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        color: Colors.white,
        child: new Container(
          child: new Container(
            padding: const EdgeInsets.all(12.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      width: 32.0,
                      height: 32.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(topic.avatar),
                        ),
                      ),
                    ),
                    new Expanded(
                        child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: new Row(
                            children: <Widget>[
                              new Text(
                                topic.memberId,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black87,
                                ),
                              ),
                              new Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.green,
                                size: 16.0,
                              ),
                              new Text(
                                "占位",
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Text(
                          "占位",
                          style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                        )
                      ],
                    )),
                    new Icon(
                      Icons.comment,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: new Text(
                        topic.replyCount,
                        style: new TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),

                /// title
                new Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    topic.title,
                    /*maxLines: 2,
                    overflow: TextOverflow.ellipsis,*/
                    style: new TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
