using System;
using UnityEngine;

[AddComponentMenu("Camera Filter Pack/Light/Water2"), ExecuteInEditMode]
public class CameraFilterPack_Light_Water2 : MonoBehaviour
{
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    [Range(0f, 10f)]
    public float Intensity = 2.4f;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    [Range(0f, 10f)]
    public float Speed = 0.2f;
    [Range(0f, 10f)]
    public float Speed_X = 0.2f;
    [Range(0f, 1f)]
    public float Speed_Y = 0.3f;
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
            this.material.SetFloat("_Value", this.Speed);
            this.material.SetFloat("_Value2", this.Speed_X);
            this.material.SetFloat("_Value3", this.Speed_Y);
            this.material.SetFloat("_Value4", this.Intensity);
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
        ChangeValue = this.Speed;
        ChangeValue2 = this.Speed_X;
        ChangeValue3 = this.Speed_Y;
        ChangeValue4 = this.Intensity;
        this.SCShader = Shader.Find("CameraFilterPack/Light_Water2");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Speed = ChangeValue;
            this.Speed_X = ChangeValue2;
            this.Speed_Y = ChangeValue3;
            this.Intensity = ChangeValue4;
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

