import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final void Function()? followPressed;
  final bool isFollowing;

  const FollowButton(
      {super.key, required this.followPressed, required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
          onPressed: followPressed,
          padding: const EdgeInsets.all(20),
          color: isFollowing ? Theme.of(context).colorScheme.primary : Colors.blue,
          child: Text(isFollowing ? "Unfollow" : 'Follow',
           style: TextStyle(color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold
           ),),
        
          ),
      ),
    );
  }
}
