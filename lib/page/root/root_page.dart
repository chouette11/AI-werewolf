import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  final String id = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "ワードウルフ",
              style: TextStyleConstant.bold28,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: ColorConstant.secondary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        content: SizedBox(
                          width: 240,
                          height: 160,
                          child: Column(
                            children: [
                              const Text(
                                'ID',
                                style: TextStyleConstant.normal32,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                id,
                                style: TextStyleConstant.normal32,
                              ),
                              const SizedBox(height: 56),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Center(
                            child: SizedBox(
                              height: 48,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: id));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('テキストがクリップボードに保存されました'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.accent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "コピー",
                                  style: TextStyleConstant.normal16.copyWith(
                                    color: ColorConstant.base,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: SizedBox(
                              height: 48,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () => context.push("/chat"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.accent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "参加する",
                                  style: TextStyleConstant.normal16.copyWith(
                                    color: ColorConstant.base,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstant.main,
                  backgroundColor: ColorConstant.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "部屋作成",
                  style: TextStyleConstant.white24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: ColorConstant.secondary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        content: const SizedBox(
                          width: 240,
                          height: 160,
                          child: Column(
                            children: [
                              Text(
                                '参加ID',
                                style: TextStyleConstant.normal32,
                              ),
                              SizedBox(height: 56),
                              SizedBox(
                                height: 40,
                                width: 224,
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  autofocus: true,
                                  cursorColor: ColorConstant.accent,
                                  decoration: InputDecoration(
                                    fillColor: ColorConstant.base,
                                    filled: true,
                                    hintText: 'IDを入力',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: ColorConstant.accent),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorConstant.accent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Center(
                            child: SizedBox(
                              height: 48,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.accent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "参加する",
                                  style: TextStyleConstant.normal16.copyWith(
                                    color: ColorConstant.base,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstant.secondary,
                  backgroundColor: ColorConstant.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "参加する",
                  style: TextStyleConstant.normal24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
