using System;
using UnityEngine;

[ExecuteInEditMode, AddComponentMenu("Camera Filter Pack/Atmosphere/Snow_8bits")]
public class CameraFilterPack_Atmosphere_Snow_8bits : MonoBehaviour
{
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    [Range(8f, 256f)]
    public float Size = 64f;
    [Range(0.9f, 2f)]
    public float Threshold = 1f;
    private float TimeX = 1f;
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
            this.material.SetFloat("_Value", this.Threshold);
            this.material.SetFloat("_Value2", this.Size);
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
        ChangeValue = this.Threshold;
        ChangeValue2 = this.Size;
        ChangeValue3 = this.Value3;
        ChangeValue4 = this.Value4;
        this.SCShader = Shader.Find("CameraFilterPack/Atmosphere_Snow_8bits");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Threshold = ChangeValue;
            this.Size = ChangeValue2;
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

