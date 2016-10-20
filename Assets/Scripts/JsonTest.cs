using UnityEngine;
using System.Collections;

public class JsonTest : MonoBehaviour {
	public class AJson {
		public string a;
		public string c;
	}
	// Use this for initialization
	void Start () {
		var ajson = JsonUtility.FromJson<AJson> ("{\"a\":1, \"b\":2}");
		if (ajson.c == null) {
			Debug.Log ("ajson.c == null");
		}
		Debug.Log (ajson.a + 
			ajson.c);
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
