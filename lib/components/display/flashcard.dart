import 'package:flutter/material.dart';
import 'package:memoir/components/display/image.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';

import '../../models/flashcards.dart';

class Tag extends StatelessWidget {
  final String tag;
  final void Function()? onDelete;
  const Tag({super.key, required this.tag, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GAP_SM, vertical: GAP_XS),
      child: InkWell(
        onTap: onDelete,
        child: Container(
          decoration: const BoxDecoration(
            color: COLOR_DISABLED,
            borderRadius: BorderRadius.all(Radius.circular(BR_SMALL)),
          ),
          padding:
              const EdgeInsets.symmetric(vertical: GAP_SM, horizontal: GAP),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("#$tag", style: TEXT_TAG),
              const SizedBox(width: GAP_SM),
              if (onDelete != null) const Icon(Icons.close, size: 16),
            ],
          ),
        ),
      ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: BORDER_THICK,
            gradient: VGRADIENT_CARD,
            borderRadius: const BorderRadius.all(Radius.circular(BR_LARGE))),
        padding: const EdgeInsets.all(GAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCardDetails(),
            const Divider(
              color: Colors.black,
              thickness: GAP_XS,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            )
          ],
        ),
      ),
    );
  }

  Row buildCardDetails() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: buildCardMetadata(),
        ),
        Flexible(
            flex: 1,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minHeight: 100.0, maxHeight: 100.0),
              child: MaybeFileImage(image: set.image, fit: BoxFit.cover),
            )),
      ],
    );
  }

  Column buildCardMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: GAP),
        Text(set.title, style: TEXT_IMPORTANT),
        Text.rich(TextSpan(children: [
          const TextSpan(
              text: "by: ",
              style: TextStyle(
                fontSize: FS_DEFAULT,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: set.owner.target == null
                  ? "Deleted User"
                  : set.owner.target!.name,
              style: set.owner.target == null ? TEXT_DISABLED : TEXT_DEFAULT),
        ])),
        if (set.description != null)
          Padding(
              padding: const EdgeInsets.only(top: GAP, bottom: GAP_LG),
              child: Text(set.description!, style: TEXT_DEFAULT)),
        Wrap(
          children: set.tags.map<Tag>((tag) => Tag(tag: tag)).toList(),
        )
      ],
    );
  }
}
