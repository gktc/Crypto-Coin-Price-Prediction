import 'dart:convert';

import 'package:crypto_price_prediction/model/details.dart';
import 'package:crypto_price_prediction/utilities/constants.dart';
import 'package:crypto_price_prediction/utilities/details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/controller.dart';
import '../functions/conversion.dart';
import '../functions/round.dart';
import '../line chart/custom_legend.dart';
import '../line chart/line_graph.dart';

class Chart extends StatelessWidget {
  final controller = Get.put(Controller());

  Data cryptoDetails;
  Chart({super.key, required this.cryptoDetails});

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];
  @override
  Widget build(BuildContext context) {
    print(json);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: CustomLegend(),
                  ),
                  Stack(
                    children: [
                      LineGraph(),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 80),
                          child: Text(
                            cryptoDetails.name.toString().toUpperCase(),
                            style: GoogleFonts.abel(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(left: 30),
                  //       width: 200,
                  //       child: TextField(
                  //         controller: _dayController,
                  //         decoration: InputDecoration(
                  //           hintText: "Enter the day",
                  //           labelText: "",
                  //           border: OutlineInputBorder(),
                  //         ),
                  //         keyboardType: TextInputType.number,
                  //         textInputAction: TextInputAction.done,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.minX.value = 0;
                        },
                        style: ButtonStyle(
                          backgroundColor: controller.minX.value == 0
                              ? MaterialStateProperty.all(Colors.grey[800])
                              : MaterialStateProperty.all(Colors.grey[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "1y",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.minX.value = controller.maxX.value - 90;
                        },
                        style: ButtonStyle(
                          backgroundColor: controller.minX.value ==
                                  controller.maxX.value - 90
                              ? MaterialStateProperty.all(Colors.grey[800])
                              : MaterialStateProperty.all(Colors.grey[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "3m",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.minX.value = controller.maxX.value - 30;
                        },
                        style: ButtonStyle(
                          backgroundColor: controller.minX.value ==
                                  controller.maxX.value - 30
                              ? MaterialStateProperty.all(Colors.grey[800])
                              : MaterialStateProperty.all(Colors.grey[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "1m",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.minX.value = controller.maxX.value - 7;
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              controller.minX.value == controller.maxX.value - 7
                                  ? MaterialStateProperty.all(Colors.grey[800])
                                  : MaterialStateProperty.all(Colors.grey[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "1w",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  HorizontalRuler(),
                  Center(
                    child: Container(
                      child: Text(
                        "Table of Prices".toUpperCase(),
                        style: GoogleFonts.abel(fontSize: 30),
                      ),
                    ),
                  ),

                  Container(
                    height: 400,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                kCardBgColor,
                                kCardGreen,
                              ],
                            ),
                          ),
                          border: TableBorder.all(
                              width: 0, color: Color.fromARGB(255, 92, 92, 92)),
                          // decoration: BoxDecoration(boxShadow: [
                          //   BoxShadow(
                          //     color: Color.fromARGB(255, 17, 17, 17),
                          //     offset: Offset(5, 5),
                          //     blurRadius: 5,
                          //   ),
                          // ], borderRadius: BorderRadius.circular(2)),
                          dataTextStyle: GoogleFonts.montserrat(fontSize: 12),
                          columnSpacing: 14,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Date',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actual Price (\$)',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Predicted Price (\$)',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                          rows: List<DataRow>.generate(
                            controller.actualPriceList.value.length,
                            (index) => DataRow(cells: [
                              DataCell(Text(
                                controller.dateList.value[index],
                              )),
                              DataCell(Container(
                                child: Text(controller
                                    .actPriceColumn.value[index]
                                    .toString()),
                              )),
                              DataCell(Container(
                                child: Text(controller
                                    .prePriceColumn.value[index]
                                    .toString()),
                              )),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  HorizontalRuler(),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Current analysis".toUpperCase(),
                        style: GoogleFonts.abel(fontSize: 30),
                      ),
                    ),
                  ),

                  // Container(child: JsonTable(json, columns: columns)),
                  DetailsCard(
                    item: "Price",
                    value: roundIt(cryptoDetails.priceUsd.toString()),
                  ),
                  DetailsCard(
                    item: "Rank",
                    value: cryptoDetails.rank.toString(),
                  ),
                  DetailsCard(
                    item: "Change percent",
                    value: roundIt(cryptoDetails.changePercent24Hr.toString()),
                  ),
                  DetailsCard(
                    item: "Market Cap USD",
                    value: convertIt(cryptoDetails.marketCapUsd.toString()),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class HorizontalRuler extends StatelessWidget {
  const HorizontalRuler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 1,
      width: double.maxFinite,
      color: Color.fromARGB(255, 92, 92, 92),
    );
  }
}

// Column(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: Stack(
//                       children: [
//                         CustomLegend(),
//                         LineGraph(),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               controller.minX.value = 0;
//                             },
//                             style: ButtonStyle(
//                               backgroundColor: controller.minX.value == 0
//                                   ? MaterialStateProperty.all(Colors.grey[800])
//                                   : MaterialStateProperty.all(Colors.grey[900]),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                 ),
//                               ),
//                             ),
//                             child: const Text(
//                               "1y",
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               controller.minX.value =
//                                   controller.maxX.value - 90;
//                             },
//                             style: ButtonStyle(
//                               backgroundColor: controller.minX.value ==
//                                       controller.maxX.value - 90
//                                   ? MaterialStateProperty.all(Colors.grey[800])
//                                   : MaterialStateProperty.all(Colors.grey[900]),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                 ),
//                               ),
//                             ),
//                             child: const Text(
//                               "3m",
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               controller.minX.value =
//                                   controller.maxX.value - 30;
//                             },
//                             style: ButtonStyle(
//                               backgroundColor: controller.minX.value ==
//                                       controller.maxX.value - 30
//                                   ? MaterialStateProperty.all(Colors.grey[800])
//                                   : MaterialStateProperty.all(Colors.grey[900]),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               "1m",
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               controller.minX.value = controller.maxX.value - 7;
//                             },
//                             style: ButtonStyle(
//                               backgroundColor: controller.minX.value ==
//                                       controller.maxX.value - 7
//                                   ? MaterialStateProperty.all(Colors.grey[800])
//                                   : MaterialStateProperty.all(Colors.grey[900]),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               "1w",
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       )),
//                   Expanded(
//                       flex: 3,
//                       child: ListView(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.red,
//                             margin: EdgeInsets.all(5),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.red,
//                             margin: EdgeInsets.all(5),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.red,
//                             margin: EdgeInsets.all(5),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.red,
//                             margin: EdgeInsets.all(5),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.red,
//                             margin: EdgeInsets.all(5),
//                           ),
//                         ],
//                       ))
//                 ],
//               );
