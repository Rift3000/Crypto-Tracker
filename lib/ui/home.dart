import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  double cardano = 0.0;
  double dogecoin = 0.0;
  double binancecoin = 0.0;

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color thirdColor = Color(0xff6C63FF);

  String displayName = "";

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString("displayName");
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
    getData();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    cardano = await getPrice("cardano");
    dogecoin = await getPrice("dogecoin");
    binancecoin = await getPrice("binancecoin");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(
      length: 5,
      units: ['k', 'kk', 'M', 'B', 'Q'],
      decimal: 1,
    );
    getValues(String id, double amount) {
      if (id == "bitcoin") {
        return display(bitcoin * amount);
      } else if (id == "ethereum") {
        return display(ethereum * amount);
      } else if (id == "tether") {
        return display(tether * amount);
      } else if (id == "cardano") {
        return display(cardano * amount);
      } else if (id == "binancecoin") {
        return display(binancecoin * amount);
      } else if (id == "dogecoin") {
        return display(dogecoin * amount);
      }
    }

    final mq = MediaQuery.of(context).size;

    displayUser() {
      if (displayName != null) {
        return Text('${displayName.replaceAll("!", "")} Portfolio',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: mq.width / 16));
      } else {
        return Text('Welcome!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: mq.width / 16));
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: false,
          title: Center(child: displayUser()),
        ),
        backgroundColor: primaryColor,
        body: Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection("Coins")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  SvgPicture.asset(
                    'images/crypto_portfolio.svg',
                    semanticsLabel: 'Add View Image',
                    height: mq.height / 3.5,
                    width: mq.width / 3.5,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: snapshot.data.docs.map((document) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              removeCoin(document.id);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Coin Deleted!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: mq.width / 18),
                                  ),
                                ],
                              ),
                              backgroundColor: thirdColor,
                            ));
                          },
                          background: Container(
                            color: Colors.lightBlueAccent,
                            child: Icon(Icons.delete,
                                color: Colors.white, size: mq.width / 10),
                            alignment: Alignment.centerRight,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 9,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                border: Border.all(
                                    color: primaryColor, width: 1.5)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${document.id.toUpperCase()}" ==
                                            "BINANCECOIN"
                                        ? "BNB"
                                        : "${document.id.toUpperCase()}",
                                    style: GoogleFonts.lato(
                                      fontSize: mq.width / 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "\$${getValues(document.id, document['Amount'])}",
                                    style: GoogleFonts.lato(
                                      fontSize: mq.width / 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
