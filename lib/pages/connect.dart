import 'package:flutter/material.dart';

List<String> mentors = [
  "Grant Williams",
  "Golden Richard",
  "Patti Aymond",
  "William Duncan",
  "Feng Chen",
  "Qingyang Wang",
  "Chen Wang",
  "Gerald Baumgartner",
  "Konstantin Busch",
  "Bijaya Karki",
  "Doris Carver",
  "Jianhua Chen",
  "Sukhamay Kundu",
  "Kisung Lee",
  "Supratik Mukhopadhyay",
  "Seung-Jong Park",
  "Rahul Shah",
  "Mingxuan Sun",
  "Evangelos Triantaphyllou",
  "Jinwei Ye",
  "Jian Zhang",
  "Nathan Brener",
  "Steve Brandt",
];

class Recommendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: DisplayRecommendations()),
    );
  }
}

class DisplayRecommendations extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _DisplayRecommendationsState();
}

class _DisplayRecommendationsState extends State<DisplayRecommendations>
{


  List randomItems = getRandomList();

  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: ListView.builder(
          itemCount: randomItems.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(randomItems[index]),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  randomItems.removeAt(index);
                });
              },
              direction: DismissDirection.endToStart,
              child: Card(
                elevation: 5,
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/rubber_duck.jpg')
                            )
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                randomItems[index],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Icon(Icons.person_add),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text("Computer Science Professor at LSU",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


  static List getRandomList()
  {
    List<String>_mentorList = mentors;
    List list = List.generate(_mentorList.length, (i) {
      _mentorList.shuffle();
      return "Mentor Name: ${_mentorList[i]}";

    });
    return list;
  }
}
