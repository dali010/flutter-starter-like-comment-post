import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/strings.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final Size size;
  final BoxShape shape;
  final String errorImage;

  const CustomNetworkImage(
      {Key? key,
      required this.imageUrl,
      required this.size,
      this.shape = BoxShape.circle,
      this.errorImage = Assets.userAvatarIcon})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: CachedNetworkImage(
          imageUrl: "${Strings.uploadsUrl}/$imageUrl",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: shape,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              shape: shape,
            ),
            child: Shimmer.fromColors(
                period: const Duration(seconds: 2),
                baseColor: const Color(0xFFadb5bd),
                highlightColor: const Color(0xFFe9ecef),
                child: errorImage.contains('.svg')
                    ? SvgPicture.asset(errorImage, fit: BoxFit.cover)
                    : Image.asset(errorImage)),
          ),
          errorWidget: (context, url, error) => errorImage.contains('.svg')
              ? SvgPicture.asset(errorImage, fit: BoxFit.cover)
              : Image.asset(errorImage),
          height: size.height,
          width: size.width,
        ));
  }
}
