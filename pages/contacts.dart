import 'package:flutter/material.dart';


class ItemModel {
  bool isExpanded;
  String header;
  //BodyModel bodyModel;

  ItemModel({this.isExpanded: false, this.header});
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
  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(header: 'Anas Nash Mahmoud'),
    ItemModel(header: 'Chen Wang'),
    ItemModel(header: 'Qingyang Wang'),
    ItemModel(header: 'Golden Richard'),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentors'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (BuildContext context, int index) {
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
                          onPressed: () {

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
                        prepareData[index].header,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: prepareData[index].isExpanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  prepareData[index].isExpanded =
                  !prepareData[index].isExpanded;
                });
              },
            );
          },
        ),
      ),
    );
  }
}