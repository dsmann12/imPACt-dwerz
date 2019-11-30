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
  
  List<ItemModel> data;
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
        if (data == null) {
          data = mentors.map((user) => ItemModel(user: user)).toList();
        } else if (data.length != mentors.length) {
          for(int i = 0; i < mentors.length; ++i) {
            if (i < data.length) {
              data[i].user = mentors[i];
            } else {
              data.add(ItemModel(user: mentors[i]));
            }
          }
        } else {
          for(int i = 0; i < data.length; ++i) {
            data[i].user = mentors[i];
          }
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Mentors'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: (data == null) ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: data?.length,
          itemBuilder: (BuildContext context, int index) {
            ItemModel item = (data == null) ? null : data[index];
            return ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              children: [
                ExpansionPanel(
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

                            Chat chat = await MessagingService.getChatBetweenUsers(currentUser.id, item.user.id);
                            if (chat == null) {
                              chat = Chat();
                              chat.ids.add(currentUser.id);
                              chat.ids.add(item.user.id);
                              chat.users[currentUser.id] = {
                                "avatarURL": currentUser.avatarURL,
                                "firstName": currentUser.firstName,
                                "lastName": currentUser.lastName,
                              }.cast<String, dynamic>();
                              chat.users[item.user.id] = {
                                "avatarURL": item.user.avatarURL,
                                "firstName": item.user.firstName,
                                "lastName": item.user.lastName,
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
                      child: Text(
                        "${item.user.firstName} ${item.user.lastName}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: (item == null) ? false : item.isExpanded,
                )
              ],
              expansionCallback: (int position, bool status) {
                setState(() {
                  item.isExpanded =
                  !item.isExpanded;
                });
              },
            );
          },
        ),
      ),
    );
  }
}