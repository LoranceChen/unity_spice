using UnityEngine;
using System.Collections;

public class PlaneCtrl : MonoBehaviour {
	public System.Action<Animator> onComplete;
	public Animator anim;
	// Use this for initialization
	void Awake () {
		anim = GetComponent<Animator> ();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void OnComplete() {
		if (onComplete != null)
			onComplete (anim);
	}
}
