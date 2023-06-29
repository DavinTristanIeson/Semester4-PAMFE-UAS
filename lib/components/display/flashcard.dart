import 'package:flutter/material.dart';
import 'package:memoir/components/display/image.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';

import '../../models/flashcards.dart';

class Tag extends StatelessWidget {
  final String tag;
  const Tag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: COLOR_DISABLED,
      ),
      child: Text.rich(TextSpan(children: [
        const TextSpan(text: '#', style: TEXT_SMALL_DETAIL),
        TextSpan(text: tag, style: TEXT_SMALL_DETAIL)
      ])),
    );
  }
}

class FlashcardSetCard extends StatelessWidget {
  final List<Widget> actions;
  final FlashcardSet set;
  final void Function()? onTap;
  const FlashcardSetCard(
      {super.key, required this.set, required this.actions, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              border: BORDER_THICK,
              borderRadius: const BorderRadius.all(Radius.circular(BR_LARGE))),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(set.title, style: TEXT_IMPORTANT),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: "by: ",
                            style: TextStyle(
                              fontSize: FS_DEFAULT,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(text: set.owner.name, style: TEXT_DEFAULT),
                      ])),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: GAP, bottom: GAP_LG),
                          child: Text(set.description, style: TEXT_DEFAULT)),
                      Wrap(
                        children:
                            set.tags.map<Tag>((tag) => Tag(tag: tag)).toList(),
                      )
                    ],
                  ),
                  MaybeFileImage(image: set.thumbnail),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              )
            ],
          )),
    );
  }
}
