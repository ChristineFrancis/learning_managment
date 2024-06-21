import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/favorite.dart';


class Favorite extends StatelessWidget {
  final bool active;
  const Favorite({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 35.0, right: 300, bottom: 4),
          child: Text(
            "Favorite:",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: " Exo 2"),
          ),
        ),
        Expanded(
            child: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15.0, left: 4, bottom: 20),
                    child: Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              // offset: const Offset(
                              //     0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple[50]),
                      //  fromARGB(255, 229, 222, 240)
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/logo.png",
                            height: 120,
                            //  width: 190,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0, left: 5),
                            child: Text("flutter",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Exo 2",
                                    fontWeight: FontWeight.w500)),
                          ),
                          GetBuilder<FavoriteController>(
                              builder: ((controller) => IconButton(
                                    padding: EdgeInsets.only(left: 130),
                                    onPressed: () {},
                                    iconSize: 30,
                                    icon: Icon(active
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined),
                                    color: Colors.red[700],
                                  )))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ))
      ],
    );
  }
}
