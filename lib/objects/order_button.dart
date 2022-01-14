import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/routes/seller_profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

DBService db = DBService();

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key, required this.status, required this.reference, required this.analytics, required this.observer})
      : super(key: key);

  final String status;
  final dynamic reference;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

bool _isExpanded = false;

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    String id = widget.reference.id.toString();
    return FutureBuilder(
      future: db.productsCollection.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
          Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              border: Border.all(
                width: 1.0,
                color: AppColors.primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15),),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 6, 6, 6),
                        child: Image.network(
                          productsClass.imageURL[0],
                          width: 80.0,
                          height: 80.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Wrap(
                            children: [
                              Text(
                                productsClass.productName,
                                style: OrdersPage_DeliveryInfo,
                              ),
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                            ),
                            child: Row(
                              children: [
                                Text('By ', style: productPageSellerText1),
                                InkWell(
                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen: SellerProfile(
                                          reference: productsClass.sellerReference,
                                          analytics: widget.analytics,
                                          observer: widget.observer),
                                    );
                                  },
                                  child: Text(
                                    productsClass.sellerName,
                                    style: productPageSellerText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${productsClass.salePrice.toString()}.00",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery Status",
                                      style: OrdersPage_DeliveryInfo,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      widget.status,
                                      style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: widget.status == "Processing"
                                              ? AppColors.processingTextColor
                                              : AppColors.deliveredTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  color: Colors.grey,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        "Total payment: ",
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Container(color: Colors.white);
      },
    );
  }
}
