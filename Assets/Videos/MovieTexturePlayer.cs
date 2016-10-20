using UnityEngine;
using System.Collections;

public class MovieTexturePlayer : MonoBehaviour {
	public MovieTexture movTexture;
	public Renderer renderer;

	// Use this for initialization
	void Start () {
		renderer.material.mainTexture = movTexture;
		movTexture.Play ();
	}

}
