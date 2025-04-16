import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A sliver that pins its child to the top of the viewport.
///
/// Similar to [SliverPersistentHeader] with pinned=true, but simpler to use
/// as it doesn't require a delegate and handles measuring itself.
class SliverPinnedHeader extends SingleChildRenderObjectWidget {
  /// Creates a sliver that pins its child to the top of the viewport.
  const SliverPinnedHeader({required Widget super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverPinnedHeader();
  }
}

/// A render object that pins its child to the top of the viewport.
class RenderSliverPinnedHeader extends RenderSliverSingleBoxAdapter {
  /// Creates a render object that pins its child to the top of the viewport.
  RenderSliverPinnedHeader({super.child});

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // Layout the child with normal box constraints
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final childHeight = child!.size.height;

    // Calculate the visible portion
    final paintedChildSize = math.min(
      childHeight,
      constraints.remainingPaintExtent,
    );

    // Calculate how much this sliver contributes to scrolling
    final scrollExtent = childHeight;

    // Calculate how much of the sliver is in the layout
    final layoutExtent = math.min(
      paintedChildSize,
      (childHeight - constraints.scrollOffset).clamp(0.0, paintedChildSize),
    );

    // Create the geometry with the proper parameters for pinning
    geometry = SliverGeometry(
      scrollExtent: scrollExtent,
      paintExtent: paintedChildSize,
      maxPaintExtent: childHeight,
      hitTestExtent: paintedChildSize,
      layoutExtent: layoutExtent,
      visible: true,
    );

    // Position the child at the top of the viewport when pinned
    (child!.parentData! as SliverPhysicalParentData).paintOffset = Offset.zero;
  }
}
