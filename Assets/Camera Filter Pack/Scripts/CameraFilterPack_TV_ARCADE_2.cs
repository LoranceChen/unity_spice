using System;
using UnityEngine;

[AddComponentMenu("Camera Filter Pack/TV/ARCADE_2"), ExecuteInEditMode]
public class CameraFilterPack_TV_ARCADE_2 : MonoBehaviour
{
    [Range(0f, 10f)]
    public float Contrast = 1f;
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    [Range(0f, 10f)]
    public float Interferance_Size = 1f;
    [Range(0f, 10f)]
    public float Interferance_Speed = 0.5f;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    private float TimeX = 1f;
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
            this.material.SetFloat("_Value", this.Interferance_Size);
            this.material.SetFloat("_Value2", this.Interferance_Speed);
            this.material.SetFloat("_Value3", this.Contrast);
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
        ChangeValue = this.Interferance_Size;
        ChangeValue2 = this.Interferance_Speed;
        ChangeValue3 = this.Contrast;
        ChangeValue4 = this.Value4;
        this.SCShader = Shader.Find("CameraFilterPack/TV_ARCADE_2");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Interferance_Size = ChangeValue;
            this.Interferance_Speed = ChangeValue2;
            this.Contrast = ChangeValue3;
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

