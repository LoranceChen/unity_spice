﻿using System;
using UnityEngine;

[AddComponentMenu("Camera Filter Pack/Film/Grain"), ExecuteInEditMode]
public class CameraFilterPack_Film_Grain : MonoBehaviour
{
    public static float ChangeValue;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    private float TimeX = 1f;
    [Range(-64f, 64f)]
    public float Value = 32f;

    private void OnDisable()
    {
        if (this.SCMaterial != null)
        {
            UnityEngine.Object.DestroyImmediate(this.SCMaterial);
        }
    }

    private void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
    {
        if (this.SCShader != null)
        {
            this.TimeX += Time.deltaTime;
            if (this.TimeX > 100f)
            {
                this.TimeX = 0f;
            }
            this.material.SetFloat("_TimeX", this.TimeX);
            this.material.SetFloat("_Value", this.Value);
            this.material.SetVector("_ScreenResolution", new Vector4((float) sourceTexture.width, (float) sourceTexture.height, 0f, 0f));
            Graphics.Blit(sourceTexture, destTexture, this.material);
        }
        else
        {
            Graphics.Blit(sourceTexture, destTexture);
        }
    }

    private void Start()
    {
        ChangeValue = this.Value;
        this.SCShader = Shader.Find("CameraFilterPack/Film_Grain");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Value = ChangeValue;
        }
    }

    private Material material
    {
        get
        {
            if (this.SCMaterial == null)
            {
                this.SCMaterial = new Material(this.SCShader);
                this.SCMaterial.hideFlags = HideFlags.HideAndDontSave;
            }
            return this.SCMaterial;
        }
    }
}

