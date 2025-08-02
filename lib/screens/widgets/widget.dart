import 'package:flutter/material.dart';


class ItemData{
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  ItemData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background

  });
}

class ItemWidget extends StatelessWidget{
  const ItemWidget({
    required this.data,
    super.key,
  });
  final ItemData data;
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex:3),
            Flexible(
              flex: 20,
              child: Image(image: data.image,)
              ),
              Text(
                data.title,
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: 'Poppins'
                  ),
                  maxLines: 1,
              ),
              const Spacer(flex: 1,),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: data.subtitleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 10)
          ],
        )
        
        ),
      ],
    );
  }
 }