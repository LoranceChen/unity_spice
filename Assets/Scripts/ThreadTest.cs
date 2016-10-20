using UnityEngine;
using System.Collections;
using System;
using System.Threading;
//using System.Threading
public class ThreadTest : MonoBehaviour {
	Action ac;
	// Use this for initialization
	void Start () {
		print(Thread.CurrentThread.ManagedThreadId);
		DelegateOnCurrentThread (() => print("current thread - " + Thread.CurrentThread.ManagedThreadId));
		acDel ();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void DelegateOnCurrentThread(Action a) {
		a ();
	}

	void acDel () {
		ac += () => print ("current thread2 - " + Thread.CurrentThread.ManagedThreadId);
		ac ();
	}
}

