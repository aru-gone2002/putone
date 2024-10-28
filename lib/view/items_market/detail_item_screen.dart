import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/item/item.dart';
import 'package:putone/theme/app_color_theme.dart';

class DetailItemScreen extends StatelessWidget {
  const DetailItemScreen({super.key, required this.userItem});

  final Item userItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Hero(
                  // 画面遷移後の Hero
                  tag: userItem.itemId, // 画面遷移前の tag と共通
                  child: ExtendedImage.network(
                    userItem.itemImgs[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    cache: true,
                    shape: BoxShape.rectangle,
                    //borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: spaceWidthMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      userItem.artistName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColorTheme.color().mainColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userItem.itemName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    if (userItem.price != 0) const SizedBox(height: 16),
                    if (userItem.price != 0)
                      Text(
                        '\$${userItem.price}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColorTheme.color().gray2,
                        ),
                      ),
                    const SizedBox(height: 32),
                    Text(
                      userItem.itemDiscription,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    if (userItem.size != '') const SizedBox(height: 24),
                    if (userItem.size != '')
                      Text(
                        'Size: ${userItem.size}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    if (userItem.categories.isNotEmpty)
                      const SizedBox(height: 32),
                    if (userItem.categories.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: userItem.categories
                            .map((category) => Chip(
                                  backgroundColor: Colors.white,
                                  label: Text(category,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  materialTapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // 追加：上下の余計なmarginを削除
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 4), // 追加：文字左右の多すぎるpaddingを調整
                                  visualDensity: const VisualDensity(
                                      horizontal: 0,
                                      vertical: -2), // 追加：文字上下の多すぎるpaddingを調整
                                ))
                            .toList(),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
