- `PlaneCtrl`'s anim varable should be init at `Awake` rather then `Start`.
- `PlaneCtrl` has `OnComplete` hoke for itself's Animator component callback and `onComplete` functional delegate for out environment register the event.
- `Rotator` init it's subitem, `PlaneCtrl`s, and manager them. But `Start` is not enough for init sequence action. A serirs Component should support custom init hoke to ensure other caller can get meanful instanced member.
- `Rotator` use `hasDoCurrentRotation` and angle [0, 1f] manager `onForward` action.Its ugly but can't avoid things. Try make those states in a minirange  is good for clean code. 
