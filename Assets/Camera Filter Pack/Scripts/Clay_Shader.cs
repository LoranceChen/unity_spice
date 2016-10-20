using System;
using UnityEngine;

[ExecuteInEditMode, AddComponentMenu("Clay Shader/Clay Screen")]
public class Clay_Shader : MonoBehaviour
{
    [Range(0f, 8f)]
    public float Background;
    public static float ChangeDotSize;
    public static float ChangeThreshold;
    [Range(0f, 8f)]
    public float DotSize = 1f;
    [Range(0f, 1f)]
    public float Inverse;
    private Material SCMaterial;
    public Shader SCShader;
    public Texture2D Texture2;
    [Range(-1f, 1f)]
    public float Threshold;
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
            this.material.SetFloat("_Distortion", this.Threshold);
            this.material.SetFloat("_DotSize", this.DotSize);
            float num = 0f;
            float num2 = 0f;
            if (this.Background == 0f)
            {
                num = 0.75f;
                num2 = 0.5f;
            }
            if (this.Background == 1f)
            {
                num = 0f;
                num2 = 0.25f;
            }
            if (this.Background == 2f)
            {
                num = 0.25f;
                num2 = 0.25f;
            }
            if (this.Background == 3f)
            {
                num = 0.5f;
                num2 = 0.25f;
            }
            if (this.Background == 4f)
            {
                num = 0.75f;
                num2 = 0.25f;
            }
            if (this.Background == 5f)
            {
                num = 0f;
                num2 = 0f;
            }
            if (this.Background == 6f)
            {
                num = 0.25f;
                num2 = 0f;
            }
            if (this.Background == 7f)
            {
                num = 0.5f;
                num2 = 0f;
            }
            if (this.Background == 8f)
            {
                num = 0.75f;
                num2 = 0f;
            }
            this.material.SetFloat("_BackGroundX", num);
            this.material.SetFloat("_BackGroundY", num2);
            this.material.SetTexture("_MainTex2", this.Texture2);
            this.material.SetFloat("_Inverse", this.Inverse);
            Graphics.Blit(sourceTexture, destTexture, this.material);
        }
        else
        {
            Graphics.Blit(sourceTexture, destTexture);
        }
    }

    private void Start()
    {
        ChangeThreshold = this.Threshold;
        ChangeDotSize = this.DotSize;
        this.Texture2 = Resources.Load("ClayShader") as Texture2D;
        this.SCShader = Shader.Find("ClayShader/Clay");
        if (!SystemInfo.supportsImageEffects)
        {
            base.enabled = false;
        }
    }

    private void Update()
    {
        if (Application.isPlaying)
        {
            this.Threshold = ChangeThreshold;
            this.DotSize = ChangeDotSize;
        }
        this.Background = Mathf.Round(this.Background);
        this.Inverse = Mathf.Round(this.Inverse);
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

