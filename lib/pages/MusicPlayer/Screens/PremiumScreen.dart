import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool plan199 = true;
  bool vipPlan = false;
  bool familyPlan = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    vipPlan = false;
                    familyPlan = false;
                    plan199 = true;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 3,
                          color: plan199
                              ? Colors.blueGrey
                              : Colors.blueGrey.shade200,
                        ),
                        color: plan199 ? Colors.white54 : Colors.transparent,
                        boxShadow: [
                          plan199
                              ? BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                          plan199
                              ? BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Individual Monthly",
                                style: TextStyle(
                                    color: plan199
                                        ? Colors.blueGrey
                                        : Colors.black54,
                                    fontSize: 19),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹199",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: plan199
                                          ? Colors.blueGrey
                                          : Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    plan199 ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Premium exclusive songs',
                                style: TextStyle(
                                  color: plan199
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    plan199 ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Offline listening',
                                style: TextStyle(
                                  color: plan199
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    plan199 ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'On-demand listening',
                                style: TextStyle(
                                  color: plan199
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    plan199 ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unlimited skips',
                                style: TextStyle(
                                  color: plan199
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    plan199 ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Ad-free music',
                                style: TextStyle(
                                  color: plan199
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "30 days free trial, then ₹ 119/month. Cancel anytime",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          )
                        ],
                      ),
                    ),
                    plan199
                        ? Positioned(
                            right: 10,
                            top: 85,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Most Popular",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    plan199 = false;
                    familyPlan = false;
                    vipPlan = true;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 3,
                            color: vipPlan
                                ? Colors.blueGrey
                                : Colors.blueGrey.shade200),
                        color: vipPlan ? Colors.white54 : Colors.transparent,
                        boxShadow: [
                          vipPlan
                              ? BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                          vipPlan
                              ? BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "VIP Plan",
                                style: TextStyle(
                                    color: vipPlan
                                        ? Colors.blueGrey
                                        : Colors.black54,
                                    fontSize: 19),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹299",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: vipPlan
                                          ? Colors.blueGrey
                                          : Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Up to 6 accounts',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Premium exclusive songs',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Offline listening',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'On-demand listening',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unlimited skips',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color:
                                    vipPlan ? Colors.blueGrey : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Ad-free music',
                                style: TextStyle(
                                  color: vipPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "Up to 6 accounts, ₹ 179/month after free trial ends. Cancel anytime",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          )
                        ],
                      ),
                    ),
                    vipPlan
                        ? Positioned(
                            right: 10,
                            top: 110,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                "VIP Plan",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    plan199 = false;
                    vipPlan = false;
                    familyPlan = true;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 3,
                            color: familyPlan
                                ? Colors.blueGrey
                                : Colors.blueGrey.shade200),
                        color: familyPlan ? Colors.white54 : Colors.transparent,
                        boxShadow: [
                          familyPlan
                              ? BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                          familyPlan
                              ? BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4),
                                )
                              : BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Family Plan",
                                style: TextStyle(
                                    color: familyPlan
                                        ? Colors.blueGrey
                                        : Colors.black54,
                                    fontSize: 19),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹349",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: familyPlan
                                          ? Colors.blueGrey
                                          : Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Up to 6 accounts',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Premium exclusive songs',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Offline listening',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'On-demand listening',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unlimited skips',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 13,
                                color: familyPlan
                                    ? Colors.blueGrey
                                    : Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Ad-free music',
                                style: TextStyle(
                                  color: familyPlan
                                      ? Colors.blueGrey
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "Up to 9 accounts, ₹ 349/month after free trial ends. Cancel anytime",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          )
                        ],
                      ),
                    ),
                    familyPlan
                        ? Positioned(
                            right: 10,
                            top: 110,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Family Plan",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            width: MediaQuery.of(context).size.width * .97,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "₹ ${plan199 ? "179" : vipPlan ? "269" : "299"}",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        Text(
                          "Saved ₹${plan199 ? "20" : vipPlan ? "30" : "50"}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Get Premium",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
