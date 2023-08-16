
import 'package:flutter/material.dart';

import '../strings.dart';

class ImageHelper {

  static Widget assets(String? path, {double? xHeight, double? xWidth, BoxFit? boxFit}) {
    path ??= Strings.fallbackAssetPath;
    return Image.asset(
      path,
      fit : boxFit ?? BoxFit.contain,
      height: xHeight ?? double.maxFinite,
      width: xWidth ?? double.maxFinite,
    );
  }

  static Widget network(String? path, {double? xHeight, double? xWidth, BoxFit boxFit = BoxFit.contain}) {
    if(path == null) {
      return assets(path);
    }
    return Image.network(
      path,
      fit : boxFit,
      height: xHeight ?? double.maxFinite,
      width: xWidth ?? double.maxFinite,
      loadingBuilder: (context, child, loadingProgress) {
        if(loadingProgress == null) {
          return child;
        }
        return assets(Strings.loadingAssetPath);
      },
      errorBuilder: (context, exception, stackTrace) {
        print(exception);
        return assets(Strings.fallbackAssetPath);
      },
    );
  }
}


