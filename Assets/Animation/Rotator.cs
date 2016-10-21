using UnityEngine;
using System.Collections;

public class Rotator : MonoBehaviour {
	public Transform lookAim;

	public PlaneCtrl[] planes;

	public bool doRotation;

	public System.Action<PlaneCtrl> onForward;
	private bool hasDoCurrentRotation;
	// Use this for initialization
	void Start () {
		foreach (var plane in planes) {
			plane.onComplete += (anim) => {
				doRotation = true;
				Debug.Log("doRotation = true;");
				anim.SetTrigger(CompleteTrigger);

			};
		}

		onForward += (face) => {
			doRotation = false;
			var anim = face.anim;
			Debug.Log("anim22222222 - " + anim.ToString());
			anim.SetTrigger(LargeTrigger);
		};
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if (doRotation) {
			transform.RotateAround (lookAim.position, lookAim.up, 30 * Time.deltaTime);
		}

		//do forward action?
		PlaneCtrl forwardPlane = null;
		foreach (var item in planes) {
			//angle
			var angle = Mathf.Acos(Vector3.Dot(lookAim.forward, item.transform.forward)) / Mathf.PI * 180;
			Debug.Log ("angle - " + angle);

			//forward is [0, 1] angle
			if (0f <= angle && angle <= 1f) {
				forwardPlane = item;
				break;
			}
		}

		if (forwardPlane != null) { // has a plane at forward direction
			if (!hasDoCurrentRotation) { //ensure only one time emit
				hasDoCurrentRotation = true;
				if (onForward != null) {
					onForward (forwardPlane);
				}
			}
		} else { // no plane at forward
			hasDoCurrentRotation = false;
		}
	}

	string LargeTrigger = "largeTrigger";
	string CompleteTrigger = "completeLarge";
}
