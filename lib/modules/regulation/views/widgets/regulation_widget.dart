import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';

import '../../models/regulation_model.dart';

class RegulationWidget extends StatelessWidget {
  final RegulationData data;
  const RegulationWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
      ),
      child: BouncingButtonHelper(
        autoWidth: true,
        autoHeight: true,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0),
        onTap: () async {
          /* Get.to(
            const RegulationListView(
              categoryId: 1,
              categoryName: "Produk Hukum",
            ),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 400),
          ); */
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xfffff2e9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/icons/balance_sheet.png',
                  ),
                  width: 22.0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        data.namaKategori ?? "-",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Google-Sans",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        data.deskripsi ?? "-",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 13,
                          fontFamily: "Google-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
