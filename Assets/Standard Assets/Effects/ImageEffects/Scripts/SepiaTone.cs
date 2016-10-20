using System;
using UnityEngine;

namespace UnityStandardAssets.ImageEffects
{
    [ExecuteInEditMode]
    [AddComponentMenu("Image Effects/Color Adjustments/Sepia Tone")]
    public class SepiaTone : ImageEffectBase
	{
		public float x, y , z;
        // Called by camera to apply image effect
        void OnRenderImage (RenderTexture source, RenderTexture destination)
		{
			material.SetFloat ("_X", x);
			material.SetFloat ("_Y", y);
			material.SetFloat ("_Z", z);

            Graphics.Blit (source, destination, material);
        }
    }
}
