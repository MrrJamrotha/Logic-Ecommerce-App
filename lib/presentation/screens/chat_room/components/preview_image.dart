import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class PreviewImage extends StatefulWidget {
  static const routeName = 'preview-image';
  const PreviewImage({super.key, required this.records});
  final List<AssetEntity> records;

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  double get _scale => _transformationController.value.row0.x;
  bool _enablePageView = true;

  late final AnimationController _dragAnimationController;

  /// Drag offset animation controller.
  late Animation<Offset> _dragAnimation;
  Offset? _dragOffset;
  Offset? _previousPosition;
  bool _enableDrag = true;

  @override
  void initState() {
    /// drag animate
    _dragAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addStatusListener((status) {
        _onAnimationEnd(status);
      });
    _dragAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_dragAnimationController);

    super.initState();
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _dragAnimationController.reset();
      setState(() {
        _dragOffset = null;
        _previousPosition = null;
      });
    }
  }

  void _onDragStart(ScaleStartDetails scaleDetails) {
    _previousPosition = scaleDetails.focalPoint;
  }

  void _onDragUpdate(ScaleUpdateDetails scaleUpdateDetails) {
    final currentPosition = scaleUpdateDetails.focalPoint;
    final previousPosition = _previousPosition ?? currentPosition;

    final newY =
        (_dragOffset?.dy ?? 0.0) + (currentPosition.dy - previousPosition.dy);
    _previousPosition = currentPosition;

    /// just update _dragOffset when _enableDrag = true
    if (_enableDrag) {
      setState(() {
        _dragOffset = Offset(0, newY);
      });
    }
  }

  /// Handles the end of an over-scroll drag event.
  ///
  /// If [scaleEndDetails] is not null, it checks if the drag offset exceeds a certain threshold
  /// and if the velocity is fast enough to trigger a pop action. If so, it pops the current route.
  void _onOverScrollDragEnd(ScaleEndDetails? scaleEndDetails) {
    if (_dragOffset == null) return;
    final dragOffset = _dragOffset!;

    final screenSize = MediaQuery.of(context).size;

    if (scaleEndDetails != null) {
      if (dragOffset.dy.abs() >= screenSize.height / 3) {
        Navigator.of(context, rootNavigator: true).pop();
        return;
      }
      final velocity = scaleEndDetails.velocity.pixelsPerSecond;
      final velocityY = velocity.dy;

      /// Make sure the velocity is fast enough to trigger the pop action
      /// Prevent mistake zoom in fast and drag => check dragOffset.dy.abs() > thresholdOffsetYToEnablePop
      const thresholdOffsetYToEnablePop = 75.0;
      const thresholdVelocityYToEnablePop = 200.0;
      if (velocityY.abs() > thresholdOffsetYToEnablePop &&
          dragOffset.dy.abs() > thresholdVelocityYToEnablePop &&
          _enableDrag) {
        Navigator.of(context, rootNavigator: true).pop();
        return;
      }
    }

    /// Reset position to center of the screen when the drag is canceled.
    setState(() {
      _dragAnimation = Tween<Offset>(
        begin: Offset(0.0, dragOffset.dy),
        end: const Offset(0.0, 0.0),
      ).animate(_dragAnimationController);
      _dragOffset = const Offset(0.0, 0.0);
      _dragAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // TODO:
            },
            icon: Icon(Icons.circle_outlined),
          )
        ],
      ),
      body: PageView.builder(
        itemCount: widget.records.length,
        itemBuilder: (context, index) {
          final entity = widget.records[index];
          return InteractiveViewer(
            transformationController: _transformationController,
            onInteractionUpdate: (details) {
              /// will update _dragOffset value
              _onDragUpdate(details);
              if (_scale == 2.5) {
                _enableDrag = true;
                _enablePageView = true;
              } else {
                _enableDrag = false;
                _enablePageView = false;
              }
              setState(() {});
            },
            onInteractionEnd: (details) {
              /// to handle end of drag action to pop page or not
              _onOverScrollDragEnd(details);
            },
            onInteractionStart: (details) {
              /// to handle to save start offset
              _onDragStart(details);
            },
            child: Hero(
              tag: 'img-${entity.id}',
              child: AssetEntityImage(
                entity,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          );
        },
      ),
    );
  }
}
