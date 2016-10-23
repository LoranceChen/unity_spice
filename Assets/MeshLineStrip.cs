using UnityEngine;
using System.Collections;

public class MeshLineStrip : MonoBehaviour {

	// Use this for initialization
	void Update () {
		Mesh mesh = GetComponent<MeshFilter>().mesh;
		mesh.SetIndices (mesh.GetIndices(0), MeshTopology.Lines, 0);
//		Vector3[] vertices = mesh.vertices;
//		Vector3[] normals = mesh.normals;
//		int i = 0;
//		while (i < vertices.Length) {
//			vertices[i] += normals[i] * Mathf.Sin(Time.time);
//			i++;
//		}
//		mesh.vertices = vertices;
	}
	
	// Update is called once per frame
//	void Update () {
//	
//	}
}
