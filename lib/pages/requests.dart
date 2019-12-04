import 'package:flutter/material.dart';
import 'package:impact/models/message.dart';
import 'package:impact/services/messaging_service.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/models/user.dart';
import 'package:impact/pages/chat.dart';
import 'package:impact/models/request.dart';
import 'package:impact/services/request_service.dart';

class RequestsPage extends StatefulWidget
{
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage>
{
  User user = AuthService.getCurrentUser();
  List<Request> requests;
  List<Request> sentRequests;
  Map<int, Color> colors = {0: Colors.black, 1: Colors.green, 2: Colors.red};
  Map<int, String> status = {0: "Submitted", 1: "Accepted", 2: "Denied"};
  
  @override
  void initState() {
    super.initState();
    RequestService.getRequestsByUser(user.id).then((requests) => setState(() {this.requests = requests;}));
    RequestService.getSentRequestsByUser(user.id).then((sentRequests) => setState(() {this.sentRequests = sentRequests;}));
    
  }

  @override
  Widget build(BuildContext context) {
    if (this.sentRequests == null || (user.isMentor() && this.requests == null)) {
      return Center(child: CircularProgressIndicator(),);
    }

    return (user.isMentor()) ? _buildMentorView() : _buildMenteeView();
  }

  Widget _buildMenteeView() {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text("imPACt")),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Text("Sent")),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildSentRequests(),
          ],
        )
      )
    );
  }

  Widget _buildMentorView() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("imPACt"),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Text("Received")),
              Tab(icon: Text("Sent")),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildReceivedRequests(),
            _buildSentRequests(),
          ],
        )
      )
    );
  }

  Widget _buildReceivedRequests() {
    return (requests == null) ? Center(child: CircularProgressIndicator()) : _buildRequestList(requests);
  }

  Widget _buildSentRequests() {
    return (requests == null) ? Center(child: CircularProgressIndicator()) : _buildSentRequestList(sentRequests);
  }

  Widget _buildRequestList(List<Request> requests) {
    if (requests.length == 0) {
      return Center(child: Text("You have no current mentor requests"),);
    }
    return ListView(
      children: requests.map((request) => _buildRequestListItem(request)).toList(),
    );
  }

  Widget _buildSentRequestList(List<Request> requests) {
    if (requests.length == 0) {
      return Center(child: Text("You have not sent out any mentor requests"),);
    }
    return ListView(
      children: requests.map((request) => _buildSentRequestListItem(request)).toList(),
    );
  }


  Widget _buildRequestListItem(Request request) {
    return GestureDetector( 
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new Card(
            elevation: 1.0,
            color: Colors.white,
            child: new ListTile(
              leading: new CircleAvatar(
                backgroundImage: new NetworkImage(request.mentee.avatarURL),
              ),
              title: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${request.mentee.firstName} ${request.mentee.lastName} ",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () => RequestService.acceptRequest(request),
                          child: Text("Accept")
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () => RequestService.denyRequest(request),
                            child: Text("Deny")
                          )
                        )
                      )
                    ]
                  ),
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: new Text(
                  "${request.mentee.institution}\n${request.mentee.department}",
                  style: new TextStyle(
                      color: Colors.grey, fontSize: 15.0),
                ),
              ),
            )
          )
        )
    );
  }

  Widget _buildSentRequestListItem(Request request) {
    return Dismissible(
      key: Key(request.toString()),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.only(right:10),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30.0
          )
        )
      ),
      onDismissed: (direction) async { await RequestService.removeRequest(request); setState(() {this.sentRequests.remove(request);});},
      direction: DismissDirection.endToStart,
      child: GestureDetector( 
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Card(
              elevation: 1.0,
              color: Colors.white,
              child: new ListTile(
                leading: new CircleAvatar(
                  backgroundImage: new NetworkImage(request.mentor.avatarURL),
                ),
                title:   Text(
                      "${request.mentor.firstName} ${request.mentor.lastName} ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                trailing: Text(status[request.status], style: TextStyle(color: colors[request.status])),
                subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "${request.mentor.institution}\n${request.mentor.department}",
                    style: new TextStyle(
                        color: Colors.grey, fontSize: 15.0),
                  ),
                ),
              )
            )
          )
      )
    );
  }
}

