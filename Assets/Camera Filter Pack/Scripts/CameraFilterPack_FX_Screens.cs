using System;
using UnityEngine;

[ExecuteInEditMode, AddComponentMenu("Camera Filter Pack/FX/Screens")]
public class CameraFilterPack_FX_Screens : MonoBehaviour
{
    public static float ChangeValue;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;
    [Range(-1f, 1f)]
    public float PosX;
    [Range(-1f, 1f)]
    public float PosY;
    private Material SCMaterial;
    private Vector4 ScreenResolution;
    public Shader SCShader;
    [Range(0f, 5f)]
    public float Speed = 0.25f;
    [Range(0f, 256f)]
    public float Tiles = 8f;
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
            this.material.SetFloat("_Value", this.Tiles);
            this.material.SetFloat("_Value2", this.Speed);
            this.material.SetFloat("_Value3", this.PosX);
            this.material.SetFloat("_Value4", this.PosY);
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
        ChangeValue = this.Tiles;
        ChangeValue2 = this.Speed;
        ChangeValue3 = this.PosX;
        ChangeValue4 = this.PosY;
        this.SCShader = Shader.Find("CameraFilterPack/FX_Screens");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Tiles = ChangeValue;
            this.Speed = ChangeValue2;
            this.PosX = ChangeValue3;
            this.PosY = ChangeValue4;
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

