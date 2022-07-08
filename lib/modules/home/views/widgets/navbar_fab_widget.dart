import 'package:flutter/material.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/helpers/fade_slide_delay.dart';

class NavBarFloatingActionButtonWidget extends StatefulWidget {
  NavBarFloatingActionButtonWidget({
    Key? key,
    required this.items,
    required this.centerItemText,
    required this.defaultSelected,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) : super(key: key) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<NavBarFloatingActionButtonItemWidget> items;
  final String centerItemText;
  final int defaultSelected;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => NavBarFloatingActionButtonWidgetState();
}

class NavBarFloatingActionButtonItemWidget {
  NavBarFloatingActionButtonItemWidget({
    //required this.iconData,
    required this.icon,
    required this.text,
  });
  //IconData iconData;
  String icon;
  String text;
}

class NavBarFloatingActionButtonWidgetState extends State<NavBarFloatingActionButtonWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelected;
  }

  updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return FadeSlideDelayHelper(
      direction: 'bottom',
      length: 0.10,
      delay: 500,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: BottomAppBar(
          elevation: 20,
          shape: widget.notchedShape,
          color: widget.backgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items,
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: widget.iconSize + 8),
            Text(
              widget.centerItemText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: widget.color,
                fontFamily: "Google-Sans",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required NavBarFloatingActionButtonItemWidget item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: BouncingButtonHelper(
            color: Colors.transparent,
            bouncDeep: 0.2,
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/icons/${item.icon}_${_selectedIndex == index ? 'active' : 'idle'}.png',
                  ),
                  width: 20.0,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  item.text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontFamily: "Google-Sans",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
