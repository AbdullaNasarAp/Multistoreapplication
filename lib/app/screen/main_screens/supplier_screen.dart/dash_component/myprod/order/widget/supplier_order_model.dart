import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:intl/intl.dart';

class SupplierOrder extends StatelessWidget {
  const SupplierOrder({super.key, this.order});
  final dynamic order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: xGrey),
            borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 80),
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 80,
                    ),
                    child: Image.network(order['orderimage']),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      TextTitle(
                          title: order['prodname'],
                          ls: 0,
                          mL: 2,
                          fontwght: FontWeight.w600,
                          fontsz: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitle(
                              title: "₹ ${order['orderprice'].toString()}",
                              ls: 0,
                              fontwght: FontWeight.w500,
                              fontsz: 17),
                          TextTitle(
                              title: "x ${order['orderqty'].toString()}",
                              ls: 0,
                              color: Colors.red,
                              fontwght: FontWeight.bold,
                              fontsz: 16)
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextTitle(
                title: "See More ..",
                ls: 0,
                fontwght: FontWeight.w500,
                fontsz: 15,
                color: xBlue,
              ),
              TextTitle(
                title: order['deliverystatus'],
                ls: 0,
                fontwght: FontWeight.w500,
                fontsz: 15,
                color: xred,
              ),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: order['deliverystatus'] == 'delivered'
                      ? Colors.red.shade200
                      : Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitle(
                      title: "Name: ${order['custname']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title: "Phone: ${order['phone']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title: "Email: ${order['email']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title: "Address: ${order['address']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title: "Payment Status: ${order['paymentstatus']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title: "Delivery Status: ${order['deliverystatus']}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    TextTitle(
                      title:
                          "Order Date: ${(DateFormat('yyyy-MM-dd').format(order['orderdate'].toDate()).toString())}",
                      ls: 0,
                      fontwght: FontWeight.w500,
                      fontsz: 16,
                    ),
                    order['deliverystatus'] == 'Delivered'
                        ? const TextTitle(
                            title: "This item has been already delivered ",
                            ls: 0,
                            fontwght: FontWeight.bold,
                            fontsz: 16)
                        : Row(
                            children: [
                              const TextTitle(
                                title: "Change Delivery Status To:",
                                ls: 0,
                                fontwght: FontWeight.w500,
                                fontsz: 16,
                              ),
                              order['deliverystatus'] == 'preparing'
                                  ? TextButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          minTime: DateTime.now(),
                                          maxTime: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                          onConfirm: (date) async {
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(order['orderid'])
                                                .update({
                                              'deliverystatus': 'Shipping',
                                              'deliverydate': date,
                                            });
                                          },
                                        );
                                      },
                                      child: const TextTitle(
                                          title: "Shipping ?",
                                          ls: 0,
                                          fontwght: FontWeight.bold,
                                          fontsz: 16))
                                  : TextButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(order['orderid'])
                                            .update({
                                          'deliverystatus': 'Delivered'
                                        });
                                      },
                                      child: const TextTitle(
                                          title: "Delivered ?",
                                          ls: 0,
                                          fontwght: FontWeight.bold,
                                          fontsz: 16))
                            ],
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
