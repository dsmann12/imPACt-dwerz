import 'package:flutter/material.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/messaging_service.dart';
import 'package:impact/services/user_service.dart';
import 'package:impact/models/message.dart';
import 'package:impact/pages/chat.dart';


class ItemModel {
  bool isExpanded;
  User user;
  //BodyModel bodyModel;

  ItemModel({this.isExpanded: false, this.user});
}

//class BodyModel {
//  int price;
//  int quantity;
//
//  BodyModel({this.price, this.quantity});
//}

class MentorList extends StatefulWidget
{
  @override
  _MentorListState createState() => _MentorListState();
}

class _MentorListState extends State<MentorList>
{
  // List<ItemModel> prepareData = <ItemModel>[
  //   ItemModel(header: 'Anas Nash Mahmoud'),
  //   ItemModel(header: 'Chen Wang'),
  //   ItemModel(header: 'Qingyang Wang'),
  //   ItemModel(header: 'Golden Richard'),
  // ];
  
  List<ItemModel> mentorsData = [];
  List<ItemModel> menteesData = [];
  final User currentUser = AuthService.getCurrentUser();

  showAlertDialog(BuildContext context)
  {
    Widget okButton = FlatButton(
      child: Text("OK, got it!"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Welcome to the imPACt Application"),
      content: Text("This app is used for connecting mentees to different mentors"),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    UserService.getMentorsByUser(currentUser.id).then((mentorList) {
      setState(() {
        List<User> mentors = mentorList;
        if (mentorsData == null) {
          mentorsData = mentors.map((user) => ItemModel(user: user)).toList();
        } else if (mentorsData.length != mentors.length) {
          for(int i = 0; i < mentors.length; ++i) {
            if (i < mentorsData.length) {
              mentorsData[i].user = mentors[i];
            } else {
              mentorsData.add(ItemModel(user: mentors[i]));
            }
          }
        } else {
          for(int i = 0; i < mentorsData.length; ++i) {
            mentorsData[i].user = mentors[i];
          }
        }
      });
    });

    if (currentUser.isMentor()) {
      UserService.getMenteesByUser(currentUser.id).then((menteeList) {
        setState(() {
          List<User> mentees = menteeList;
          if (menteesData == null) {
            menteesData = mentees.map((user) => ItemModel(user: user)).toList();
          } else if (menteesData.length != mentees.length) {
            for(int i = 0; i < mentees.length; ++i) {
              if (i < menteesData.length) {
                menteesData[i].user = mentees[i];
              } else {
                menteesData.add(ItemModel(user: mentees[i]));
              }
            }
          } else {
            for(int i = 0; i < mentorsData.length; ++i) {
              menteesData[i].user = mentees[i];
            }
          }
        });
      });
    }

    return (mentorsData == null || (currentUser.isMentor() && (menteesData == null))) ? Center(child: CircularProgressIndicator(),) :
    Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: (mentorsData.length == 0 && menteesData.length == 0) ? Center(child: Text("You do not have any mentors or mentees"),) : ListView(
                children: <Widget>[
                  (mentorsData.length == 0) ? SizedBox.shrink() : Column(
                    children: <Widget>[
                      AppBar(
                        title: Center(
                          child: Text("Mentors"),
                        ),
                      ),
                      Column(
                        children: mentorsData.map((userItem) => _buildListItem(userItem)).toList(),
                      )
                    ],
                  ),
                // ),
                  (!currentUser.isMentor() || menteesData?.length == 0) ? SizedBox.shrink() : (menteesData.length == 0) ? Center(child: Text("You do not have any mentees")) : Column(
                    children: <Widget>[
                      AppBar(
                        title: Center(
                          child: Text("Mentees"),
                        ),
                      ),
                      Column(
                        children: menteesData.map((userItem) => _buildListItem(userItem)).toList(),
                      ),
                    ],
                  )
                ],
              ),
            )
            // )
          ],
        ),
      ),
//         child: (data == null) ? Center(child: CircularProgressIndicator()) : ListView.builder(
//           itemCount: data?.length,
//           itemBuilder: (BuildContext context, int index) {
//             ItemModel item = (data == null) ? null : data[index];
//             return ExpansionPanelList(
//               animationDuration: Duration(milliseconds: 500),
//               children: [
//                 ExpansionPanel(
//                   canTapOnHeader: true,
//                   body: Container(
//                     padding: EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
// //                        Text(
// //                          'PRICE: ${prepareData[index].bodyModel.price}',
// //                          style: TextStyle(
// //                            color: Colors.grey[700],
// //                            fontSize: 18,
// //                          ),
// //                        ),
//                         IconButton(
//                           icon: Icon(Icons.message),
//                           onPressed: () async {

//                             Chat chat = await MessagingService.getChatBetweenUsers(currentUser.id, item.user.id);
//                             if (chat == null) {
//                               chat = Chat();
//                               chat.ids.add(currentUser.id);
//                               chat.ids.add(item.user.id);
//                               chat.users[currentUser.id] = {
//                                 "avatarURL": currentUser.avatarURL,
//                                 "firstName": currentUser.firstName,
//                                 "lastName": currentUser.lastName,
//                               }.cast<String, dynamic>();
//                               chat.users[item.user.id] = {
//                                 "avatarURL": item.user.avatarURL,
//                                 "firstName": item.user.firstName,
//                                 "lastName": item.user.lastName,
//                               }.cast<String, dynamic>();
//                             }
                            
//                             Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ChatPage(currentUser, chat)));
//                           },
//                         ),
// //                        Text(
// //                          'QUANTITY: ${prepareData[index].bodyModel.quantity}',
// //                          style: TextStyle(
// //                            color: Colors.grey[700],
// //                            fontSize: 18,
// //                          ),
// //                        )
//                        IconButton(
//                          icon: Icon(Icons.info),
//                          onPressed: () {
                           
//                          },
//                        )
//                       ],
//                     ),
//                   ),
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return Container(
//                       padding: EdgeInsets.all(10),
//                       child: Row(
//                         children: <Widget>[
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(item.user.avatarURL),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text(
//                               "${item.user.firstName} ${item.user.lastName}",
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ) 
//                     );
//                   },
//                   isExpanded: (item == null) ? false : item.isExpanded,
//                 )
//               ],
//               expansionCallback: (int position, bool status) {
//                 setState(() {
//                   item.isExpanded =
//                   !item.isExpanded;
//                 });
//               },
//             );
//           },
//         ),
    );
  }

  ListView _buildList(List<ItemModel> users) {
    return ListView(
      children: users.map((userItem) => _buildListItem(userItem)).toList(),
    );
  }

  Widget _buildListItem(ItemModel userItem) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          body: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
//                        Text(
//                          'PRICE: ${prepareData[index].bodyModel.price}',
//                          style: TextStyle(
//                            color: Colors.grey[700],
//                            fontSize: 18,
//                          ),
//                        ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () async {

                    Chat chat = await MessagingService.getChatBetweenUsers(currentUser.id, userItem.user.id);
                    if (chat == null) {
                      chat = Chat();
                      chat.ids.add(currentUser.id);
                      chat.ids.add(userItem.user.id);
                      chat.users[currentUser.id] = {
                        "avatarURL": currentUser.avatarURL,
                        "firstName": currentUser.firstName,
                        "lastName": currentUser.lastName,
                      }.cast<String, dynamic>();
                      chat.users[userItem.user.id] = {
                        "avatarURL": userItem.user.avatarURL,
                        "firstName": userItem.user.firstName,
                        "lastName": userItem.user.lastName,
                      }.cast<String, dynamic>();
                    }
                    
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ChatPage(currentUser, chat)));
                  },
                ),
//                        Text(
//                          'QUANTITY: ${prepareData[index].bodyModel.quantity}',
//                          style: TextStyle(
//                            color: Colors.grey[700],
//                            fontSize: 18,
//                          ),
//                        )
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    
                  },
                )
              ],
            ),
          ),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userItem.user.avatarURL),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "${userItem.user.firstName} ${userItem.user.lastName}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ) 
            );
          },
          isExpanded: (userItem == null) ? false : userItem.isExpanded,
        )
      ],
      expansionCallback: (int position, bool status) {
        setState(() {
          userItem.isExpanded =
          !userItem.isExpanded;
        });
      },
    );
  }

}