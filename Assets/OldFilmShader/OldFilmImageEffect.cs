using UnityEngine;
using System.Collections;

/// <summary>
/// Old film image effect.
/// https://docs.unity3d.com/Manual/WritingImageEffects.html
/// 
/// OnRenderImage:
/// https://docs.unity3d.com/ScriptReference/MonoBehaviour.OnRenderImage.html
/// </summary>
//namespace UnityStandardAssets.ImageEffects {
	public class OldFilmImageEffect : MonoBehaviour {
//		public Texture  textureRamp;
//		public Shader oldFilm;
		public Material mat;
		void OnRenderImage(RenderTexture src, RenderTexture dest) {
//			material.shader = oldFilm;

			var f = mat.GetFloat("InnerVignetting");
//			material.SetFloat("InnerVignetting", 0.1f);
			Debug.Log ("aaa - " + f);


//			int rtW = src.width/4;
//			int rtH = src.height/4;
//			RenderTexture buffer = RenderTexture.GetTemporary(rtW, rtH, 0);

			Graphics.Blit(src, dest, mat);
//			dest = src;

//			RenderTexture.ReleaseTemporary(dest);
//			Graphics.Blit(src, dest, mat);
		}
	}
//}
