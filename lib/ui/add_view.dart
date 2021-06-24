import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
    "cardano",
    "dogecoin",
    "binancecoin",
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final Color primaryColor = Color(0xff18203d);
    final Color secondaryColor = Color(0xff232c51);

    final Color thirdColor = Color(0xff6C63FF);

    return Material(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'images/eth_balloon.svg',
            semanticsLabel: 'Add View Image',
            height: mq.height / 3.5,
            width: mq.width / 3.5,
          ),
          DropdownButton(
            icon: Icon(
              Icons.arrow_drop_down_circle_sharp,
              color: Colors.white,
            ),
            iconSize: 24,
            elevation: 16,
            dropdownColor: primaryColor,
            style: TextStyle(color: Colors.white, fontSize: 22),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            value: dropdownValue,
            onChanged: (String value) {
              setState(() {
                dropdownValue = value;
              });
            },
            items: coins.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              },
            ).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Coin Amount",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () async {
                await addCoin(dropdownValue, _amountController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Coin Added!',
                        style: TextStyle(
                            color: Colors.white, fontSize: mq.width / 18),
                      ),
                    ],
                  ),
                  backgroundColor: thirdColor,
                ));
              },
              color: Colors.deepPurpleAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Add',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  Icon(Icons.add)
                ],
              ),
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.0,
          )
        ],
      ),
    );
  }
}
