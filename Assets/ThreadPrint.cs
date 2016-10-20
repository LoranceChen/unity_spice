using UnityEngine;
using System.Collections;
using System.Threading;
using System;

public class ThreadPrint : MonoBehaviour {
	public delegate void MyDel();
	public Action action;
	MyDel myDel;

	void Start() {
		action += StartThread;

		action();
	}

	// Use this for initialization
	void StartThread () {
		Thread thread = new Thread(doThings);
		thread.Name = "thName";
		thread.Start ();
//		doThings();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void doThings() {
		print ("thread name - " + Thread.CurrentThread.Name + " - " +  "hi");
		var lookAtParam = new Vector3 (1f, 1f, 1f);
		transform.LookAt(lookAtParam);
//		gameObject.AddComponent<>;
		var x = transform.lossyScale;
		print ("lossyScale - " + x);
	}
}
