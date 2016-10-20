using System;
using UnityEngine;

[AddComponentMenu("Camera Filter Pack/TV/Old_Movie_2"), ExecuteInEditMode]
public class CameraFilterPack_TV_Old_Movie_2 : MonoBehaviour
{
    [Range(0f, 4f)]
    public float Burn;
    [Range(0f, 5f)]
    public float Contrast = 1f;
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    [Range(1f, 60f)]
    public float FramePerSecond = 15f;
    [Range(0f, 16f)]
    public float SceneCut = 1f;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    private float TimeX = 1f;

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
            this.material.SetFloat("_Value", this.FramePerSecond);
            this.material.SetFloat("_Value2", this.Contrast);
            this.material.SetFloat("_Value3", this.Burn);
            this.material.SetFloat("_Value4", this.SceneCut);
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
        ChangeValue = this.FramePerSecond;
        ChangeValue2 = this.Contrast;
        ChangeValue3 = this.Burn;
        ChangeValue4 = this.SceneCut;
        this.SCShader = Shader.Find("CameraFilterPack/TV_Old_Movie_2");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.FramePerSecond = ChangeValue;
            this.Contrast = ChangeValue2;
            this.Burn = ChangeValue3;
            this.SceneCut = ChangeValue4;
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

