import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/payment.dart';

Future<Payment> showBottomSheetPaymentPage(BuildContext context) async {
  Payment result = await showModalBottomSheet(
      isDismissible: false,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      enableDrag: false,
      builder: (context) {
        return const showListPaymentPage();
      });
  return result;
}

class showListPaymentPage extends StatefulWidget {
  const showListPaymentPage({super.key});

  @override
  State<showListPaymentPage> createState() => _showListPaymentPageState();
}

class _showListPaymentPageState extends State<showListPaymentPage> {
  late Payment payment;
  @override
  void initState() {
    for (var element in listPayments) {
      if (element.isSelected == true) {
        payment = element;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context, payment),
            icon: const Icon(Icons.close),
          ),
          title: const Text('Payment',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(endIndent: 20, indent: 20, thickness: 1.0),
              itemCount: listPayments.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  tristate: true,
                  controlAffinity: ListTileControlAffinity.platform,
                  value: listPayments[index].isSelected,
                  title: Text(
                    listPayments[index].name,
                    style: TextStyle(
                        color: listPayments[index].isSelected!
                            ? Colors.black
                            : Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  dense: true,
                  selected: listPayments[index].isSelected!,
                  checkColor: Colors.green,
                  activeColor: Colors.transparent,
                  side: const BorderSide(
                      style: BorderStyle.none,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.white),
                  secondary: Image.asset(
                    listPayments[index].images,
                    fit: BoxFit.contain,
                    isAntiAlias: true,
                    filterQuality: FilterQuality.high,
                    scale: 3,
                  ),
                  onChanged: (value) {
                    setState(() {
                      for (var element in listPayments) {
                        if (element.isSelected =
                            true && element.name != listPayments[index].name) {
                          element.isSelected = false;
                        } else if (element.isSelected =
                            true && element.name == listPayments[index].name) {
                          listPayments[index].isSelected = true;
                        } else {
                          listPayments[index].isSelected = value ?? false;
                        }
                      }
                      payment = listPayments[index];
                      print(payment.name);
                    });
                  },
                );
              },
            ),
          ),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width - 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.pop(context, payment);
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
