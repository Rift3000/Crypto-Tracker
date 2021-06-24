import 'package:crypto_wallet/net/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';

class Prices extends StatefulWidget {
  @override
  _PricesState createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  double cardano = 0.0;
  double dogecoin = 0.0;
  double binancecoin = 0.0;

  double bitcoinCap = 0.0;
  double ethereumCap = 0.0;
  double tetherCap = 0.0;
  double cardanoCap = 0.0;
  double dogecoinCap = 0.0;
  double binancecoinCap = 0.0;

  @override
  void initState() {
    super.initState();
    localPrices();
    getCaps();
  }

  localPrices() async {
    bitcoin = await localPrice("bitcoin");
    ethereum = await localPrice("ethereum");
    tether = await localPrice("tether");
    cardano = await localPrice("cardano");
    dogecoin = await localPrice("dogecoin");
    binancecoin = await localPrice("binancecoin");
    setState(() {});
  }

  getCaps() async {
    bitcoinCap = await getMarketCap("bitcoin");
    ethereumCap = await getMarketCap("ethereum");
    tetherCap = await getMarketCap("tether");
    cardanoCap = await getMarketCap("cardano");
    dogecoinCap = await getMarketCap("dogecoin");
    binancecoinCap = await getMarketCap("binancecoin");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    localPrices(String id) {
      if (id == "bitcoin") {
        return bitcoin;
      } else if (id == "ethereum") {
        return ethereum;
      } else if (id == "tether") {
        return tether;
      } else if (id == "cardano") {
        return cardano;
      } else if (id == "binancecoin") {
        return binancecoin;
      } else if (id == "dogecoin") {
        return dogecoin;
      }
    }

    getCaps(String id) {
      if (id == "bitcoin") {
        return bitcoinCap;
      } else if (id == "ethereum") {
        return ethereumCap;
      } else if (id == "tether") {
        return tetherCap;
      } else if (id == "cardano") {
        return cardanoCap;
      } else if (id == "dogecoin") {
        return dogecoinCap;
      } else if (id == "binancecoin") {
        return binancecoinCap;
      }
    }

    final display = createDisplay(
      length: 6,
      units: ['k', 'kk', 'M', 'B', 'Q'],
      decimal: 1,
    );

    final mq = MediaQuery.of(context).size;
    final Color primaryColor = Color(0xff18203d);
    final Color secondaryColor = Color(0xff232c51);
    /* == "BINANCECOIN"
                                ? "BNB"
                                : "${coins[index]}".toUpperCase() */

    List<String> coins = [
      "bitcoin",
      "tether",
      "ethereum",
      "cardano",
      "dogecoin",
      "binancecoin"
    ];

    return Material(
      color: primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: 35.0,
          ),
          SvgPicture.asset(
            'images/bitcoin_2.svg',
            semanticsLabel: 'Welcome Image',
            height: mq.height / 4,
            width: mq.width / 4,
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Coin",
                  style: GoogleFonts.lato(
                    fontSize: mq.width / 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Price",
                  style: GoogleFonts.lato(
                    fontSize: mq.width / 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text("Market Cap",
                    style: GoogleFonts.lato(
                      fontSize: mq.width / 17,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              height: 10,
              color: Colors.deepPurpleAccent,
              thickness: 8,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                return Container(
                  height: mq.height / 8,
                  width: mq.width / 3,
                  child: Card(
                    color: secondaryColor,
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${coins[index]}".toUpperCase() == "BINANCECOIN"
                                  ? "BNB"
                                  : "${coins[index]}".toUpperCase(),
                              style: GoogleFonts.lato(
                                fontSize: mq.width / 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                          Text("${localPrices(coins[index])}",
                              style: GoogleFonts.lato(
                                fontSize: mq.width / 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                          Text("${display(getCaps(coins[index]))}",
                              style: GoogleFonts.lato(
                                fontSize: mq.width / 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
