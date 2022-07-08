import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/races/views/race_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';

class ExploreServiceMenuWidget extends StatelessWidget {
  const ExploreServiceMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BouncingButtonHelper(
              width: (mediaSize.width - 44 - 24) / 3,
              color: const Color(0xFFf0635a),
              borderRadius: BorderRadius.circular(30.0),
              bouncDeep: 0.2,
              onTap: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  'Regulations',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
            ),
            BouncingButtonHelper(
              width: (mediaSize.width - 44 - 24) / 3,
              //enable: false,
              color: const Color(0xFFf59762),
              borderRadius: BorderRadius.circular(30.0),
              bouncDeep: 0.2,
              onTap: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  'License',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
            ),
            BouncingButtonHelper(
              width: (mediaSize.width - 44 - 24) / 3,
              color: const Color(0xFF29d697),
              borderRadius: BorderRadius.circular(30.0),
              bouncDeep: 0.2,
              onTap: () {
                Get.to(
                  const RaceView(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 400),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  'Races',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Google-Sans",
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
