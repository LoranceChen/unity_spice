using System;
using UnityEngine;

[ExecuteInEditMode, AddComponentMenu("Camera Filter Pack/TV/Chromatical2")]
public class CameraFilterPack_TV_Chromatical2 : MonoBehaviour
{
    [Range(0f, 10f)]
    public float Aberration = 2f;
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    private float TimeX = 1f;
    [Range(0f, 10f)]
    private float Value2 = 1f;
    [Range(0f, 10f)]
    private float Value3 = 1f;
    [Range(0f, 10f)]
    private float Value4 = 1f;

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
            this.material.SetFloat("_Value", this.Aberration);
            this.material.SetFloat("_Value2", this.Value2);
            this.material.SetFloat("_Value3", this.Value3);
            this.material.SetFloat("_Value4", this.Value4);
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
        ChangeValue = this.Aberration;
        ChangeValue2 = this.Value2;
        ChangeValue3 = this.Value3;
        ChangeValue4 = this.Value4;
        this.SCShader = Shader.Find("CameraFilterPack/TV_Chromatical2");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Aberration = ChangeValue;
            this.Value2 = ChangeValue2;
            this.Value3 = ChangeValue3;
            this.Value4 = ChangeValue4;
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

