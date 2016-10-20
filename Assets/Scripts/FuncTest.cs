using UnityEngine;
using System.Collections;
using System;
public class FuncTest : MonoBehaviour {
	Func<String, bool> func;
	Action<string> act;
	// Use this for initialization
	void Start () {
//		func ("a");
//		act ("");

		Action<string> myact = null;
		myact += (xx) => {
			Debug.Log("x - " + xx);
		};


		myact += (xx) => {
			Debug.Log("x - " + xx);
		};

		myact ("1234");

		Action<string> myact2 = null;
		myact2 += PrintLog;
		myact2 += PrintLog;
		myact2 ("abcd");
	}

	void PrintLog(string s){
		Debug.Log("x - " + s);
	}
}
