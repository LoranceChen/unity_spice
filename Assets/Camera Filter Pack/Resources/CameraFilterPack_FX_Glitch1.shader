Shader "CameraFilterPack/FX_Glitch1" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TimeX ("Time", Range(0,1)) = 1
 _ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
}
SubShader { 
 Pass {
  ZTest Always
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;

void main ()
{
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD0;
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec3 sample_yuv_1;
  vec2 uv_nm_2;
  float tmpvar_3;
  tmpvar_3 = (16.0 * fract((sin(dot (((floor((xlv_TEXCOORD0.yy * vec2(16.0, 16.0))) / vec2(16.0, 16.0)) + (150.0 * (floor((_TimeX * 4.0)) / 4.0))), vec2(12.9898, 78.233))) * 43758.5)));
  float tmpvar_4;
  tmpvar_4 = (5.0 * (floor((_TimeX * tmpvar_3)) / tmpvar_3));
  float tmpvar_5;
  tmpvar_5 = ((((0.5 * fract((sin(dot ((floor(((xlv_TEXCOORD0.yy + tmpvar_4) * vec2(11.0, 11.0))) / vec2(11.0, 11.0)), vec2(12.9898, 78.233))) * 43758.5))) + (0.5 * fract((sin(dot ((floor(((xlv_TEXCOORD0.yy + tmpvar_4) * vec2(7.0, 7.0))) / vec2(7.0, 7.0)), vec2(12.9898, 78.233))) * 43758.5)))) * 2.0) - 1.0);
  float tmpvar_6;
  tmpvar_6 = (sign(tmpvar_5) * clamp (((abs(tmpvar_5) - 0.6) / 0.4), 0.0, 1.0));
  vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = (0.1 * tmpvar_6);
  vec2 tmpvar_8;
  tmpvar_8 = clamp ((xlv_TEXCOORD0 + tmpvar_7), vec2(0.0, 0.0), vec2(1.0, 1.0));
  uv_nm_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = fract((sin(dot (vec2((floor((_TimeX * 8.0)) / 8.0)), vec2(12.9898, 78.233))) * 43758.5));
  float tmpvar_10;
  tmpvar_10 = mix (1.0, 0.975, clamp (0.4, 0.0, 1.0));
  float tmpvar_11;
  if ((tmpvar_9 > tmpvar_10)) {
    tmpvar_11 = (1.0 - tmpvar_8.y);
  } else {
    tmpvar_11 = tmpvar_8.y;
  };
  uv_nm_2.y = tmpvar_11;
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_nm_2);
  vec3 yuv_13;
  yuv_13.x = dot (tmpvar_12.xyz, vec3(0.299, 0.587, 0.114));
  yuv_13.y = dot (tmpvar_12.xyz, vec3(-0.14713, -0.28886, 0.436));
  yuv_13.z = dot (tmpvar_12.xyz, vec3(0.615, -0.51499, -0.10001));
  sample_yuv_1.x = yuv_13.x;
  sample_yuv_1.y = (yuv_13.y / (1.0 - ((3.0 * abs(tmpvar_6)) * clamp ((0.5 - tmpvar_6), 0.0, 1.0))));
  sample_yuv_1.z = (yuv_13.z + ((0.125 * tmpvar_6) * clamp ((tmpvar_6 - 0.5), 0.0, 1.0)));
  vec3 rgb_14;
  rgb_14.x = (yuv_13.x + (sample_yuv_1.z * 1.13983));
  rgb_14.y = (yuv_13.x + dot (vec2(-0.39465, -0.5806), sample_yuv_1.yz));
  rgb_14.z = (yuv_13.x + (sample_yuv_1.y * 2.03211));
  vec4 tmpvar_15;
  tmpvar_15.xyz = rgb_14;
  tmpvar_15.w = tmpvar_12.w;
  gl_FragData[0] = tmpvar_15;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 6 ALU
dcl_texcoord0 o0
dcl_position o1
dcl_color0 o2
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov o2, v1
mov o0.xy, v2
dp4 o1.w, v0, c3
dp4 o1.z, v0, c2
dp4 o1.y, v0, c1
dp4 o1.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 0 [_TimeX]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 122 ALU, 1 TEX
dcl_2d s0
def c1, 16.00000000, 4.00000000, 37.50000000, 0.06250000
def c2, 12.98980045, 78.23300171, 0.15915491, 0.50000000
def c3, 6.28318501, -3.14159298, 43758.54687500, 5.00000000
def c4, 11.00000000, 1.18089104, 7.11209106, 7.00000000
def c5, 1.85568583, 11.17614365, 1.00000000, 0.00000000
def c6, -0.60000002, 2.50000000, -0.50000000, 8.00000000
def c7, 1.62372506, 9.77912521, -0.99000001, 0.10000000
def c8, 0.61500001, -0.51498997, -0.10001000, 0.12500000
def c9, 0.29899999, 0.58700001, 0.11400000, 1.13982999
def c10, -0.14713000, -0.28885999, 0.43599999, 2.03210998
def c11, 3.00000000, 1.00000000, -0.39465001, -0.58060002
dcl_texcoord0 v0.xy
mov r0.x, c0
mul r0.y, c1, r0.x
frc r0.z, r0.y
add r0.z, r0.y, -r0
mul r0.x, v0.y, c1
frc r0.y, r0.x
add r0.x, r0, -r0.y
mul r0.z, r0, c1
mad r0.x, r0, c1.w, r0.z
mul r0.xy, r0.x, c2
add r0.x, r0, r0.y
mad r0.x, r0, c2.z, c2.w
frc r0.x, r0
mad r1.x, r0, c3, c3.y
sincos r0.xy, r1.x
mul r0.x, r0.y, c3.z
frc r0.x, r0
mul r0.x, r0, c1
mul r0.y, r0.x, c0.x
frc r0.z, r0.y
rcp r0.w, r0.x
add r0.x, r0.y, -r0.z
mul r0.x, r0, r0.w
mad r0.x, r0, c3.w, v0.y
mul r0.z, r0.x, c4.w
frc r0.w, r0.z
mul r0.x, r0, c4
frc r0.y, r0.x
add r0.z, r0, -r0.w
mul r0.zw, r0.z, c5.xyxy
add r0.x, r0, -r0.y
mul r0.xy, r0.x, c4.yzzw
add r0.x, r0, r0.y
add r0.z, r0, r0.w
mad r0.y, r0.z, c2.z, c2.w
frc r0.y, r0
mad r0.x, r0, c2.z, c2.w
frc r0.x, r0
mad r1.x, r0.y, c3, c3.y
mad r2.x, r0, c3, c3.y
sincos r0.xy, r1.x
sincos r1.xy, r2.x
mul r0.x, r1.y, c3.z
mul r0.y, r0, c3.z
frc r0.y, r0
frc r0.x, r0
add r0.x, r0, r0.y
mad r0.z, r0.x, c5, -c5
cmp r0.y, r0.z, c5.w, c5.z
cmp r0.x, -r0.z, c5.w, c5.z
add r0.x, r0, -r0.y
mov r0.y, c0.x
mul r0.w, c6, r0.y
abs r0.z, r0
add r0.y, r0.z, c6.x
frc r0.z, r0.w
mul_sat r0.y, r0, c6
mul r1.x, r0, r0.y
add r0.z, r0.w, -r0
mul r0.xy, r0.z, c7
add r0.x, r0, r0.y
mad r0.x, r0, c2.z, c2.w
frc r0.x, r0
abs r0.z, r1.x
add_sat r0.y, -r1.x, c2.w
mul r0.y, r0.z, r0
mad r1.y, -r0, c11.x, c11
mad r1.w, r0.x, c3.x, c3.y
sincos r0.xy, r1.w
mul r0.y, r0, c3.z
frc r0.y, r0
mul r1.z, r1.x, c7.w
mov r1.w, c5
add_sat r0.zw, v0.xyxy, r1
add_sat r1.w, r1.x, c6.z
mov r0.x, r0.z
mul r1.x, r1, r1.w
add r0.z, -r0.w, c5
add r0.y, r0, c7.z
cmp r0.y, -r0, r0.w, r0.z
texld r0, r0, s0
rcp r1.z, r1.y
dp3 r1.y, r0, c10
mul r1.z, r1.y, r1
dp3 r1.y, r0, c8
mad r1.w, r1.x, c8, r1.y
dp3 r0.x, r0, c9
mov r1.x, r1.z
mov r1.y, r1.w
mul r1.xy, r1, c11.zwzw
add r1.x, r1, r1.y
add oC0.y, r0.x, r1.x
mad oC0.x, r1.w, c9.w, r0
mad oC0.z, r1, c10.w, r0.x
mov oC0.w, r0
"
}
}
 }
}
}