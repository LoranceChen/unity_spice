Shader "CameraFilterPack/Atmosphere_Snow_8bits" {
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
uniform float _Value2;
uniform float _Value;
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (((xlv_TEXCOORD0 * 2.0) - 0.5) * vec2(1.07672, 0.916887));
  vec2 x_2;
  x_2 = ((tmpvar_1 * 1.01) + (vec2(_TimeX) * vec2(0.02, 0.501)));
  float t_3;
  t_3 = max (min (((((fract((sin(dot (floor(((x_2 - floor(x_2)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * 0.9) * _Value) - 0.9) / 0.1), 1.0), 0.0);
  vec2 x_4;
  x_4 = ((tmpvar_1 * 1.07) + (vec2(_TimeX) * vec2(0.02, 0.501)));
  float t_5;
  t_5 = max (min ((((fract((sin(dot (floor(((x_4 - floor(x_4)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.9) / 0.1), 1.0), 0.0);
  vec2 x_6;
  x_6 = (tmpvar_1 + (vec2(_TimeX) * vec2(0.05, 0.5)));
  float t_7;
  t_7 = max (min (((((fract((sin(dot (floor(((x_6 - floor(x_6)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * 0.98) * _Value) - 0.9) / 0.1), 1.0), 0.0);
  vec2 x_8;
  x_8 = ((tmpvar_1 * 0.9) + (vec2(_TimeX) * vec2(0.02, 0.51)));
  float t_9;
  t_9 = max (min (((((fract((sin(dot (floor(((x_8 - floor(x_8)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * 0.99) * _Value) - 0.9) / 0.1), 1.0), 0.0);
  vec2 x_10;
  x_10 = ((tmpvar_1 * 0.75) + (vec2(_TimeX) * vec2(0.07, 0.493)));
  float t_11;
  t_11 = max (min ((((fract((sin(dot (floor(((x_10 - floor(x_10)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.9) / 0.1), 1.0), 0.0);
  vec2 x_12;
  x_12 = ((tmpvar_1 * 0.5) + (vec2(_TimeX) * vec2(0.03, 0.504)));
  float t_13;
  t_13 = max (min ((((fract((sin(dot (floor(((x_12 - floor(x_12)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.94) / 0.06), 1.0), 0.0);
  vec2 x_14;
  x_14 = ((tmpvar_1 * 0.3) + (vec2(_TimeX) * vec2(0.02, 0.497)));
  float t_15;
  t_15 = max (min ((((fract((sin(dot (floor(((x_14 - floor(x_14)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.95) / 0.05), 1.0), 0.0);
  vec2 x_16;
  x_16 = ((tmpvar_1 * 0.1) + (vec2(_TimeX) * vec2(0.0, 0.51)));
  float t_17;
  t_17 = max (min ((((fract((sin(dot (floor(((x_16 - floor(x_16)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.96) / 0.04), 1.0), 0.0);
  vec2 x_18;
  x_18 = ((tmpvar_1 * 0.03) + (vec2(_TimeX) * vec2(0.0, 0.523)));
  float t_19;
  t_19 = max (min ((((fract((sin(dot (floor(((x_18 - floor(x_18)) * _Value2)), vec2(12.9898, 78.233))) * 43758.5)) * _Value) - 0.99) / 0.00999999), 1.0), 0.0);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = mix (mix (mix (mix (mix (mix (mix (mix (mix (texture2D (_MainTex, xlv_TEXCOORD0).xyz, vec3(1.0, 1.0, 1.0), vec3((t_3 * (t_3 * (3.0 - (2.0 * t_3)))))), vec3(1.0, 1.0, 1.0), vec3((t_5 * (t_5 * (3.0 - (2.0 * t_5)))))), vec3(1.0, 1.0, 1.0), vec3((t_7 * (t_7 * (3.0 - (2.0 * t_7)))))), vec3(1.0, 1.0, 1.0), vec3((t_9 * (t_9 * (3.0 - (2.0 * t_9)))))), vec3(1.0, 1.0, 1.0), vec3((t_11 * (t_11 * (3.0 - (2.0 * t_11)))))), vec3(1.0, 1.0, 1.0), vec3((t_13 * (t_13 * (3.0 - (2.0 * t_13)))))), vec3(1.0, 1.0, 1.0), vec3((t_15 * (t_15 * (3.0 - (2.0 * t_15)))))), vec3(1.0, 1.0, 1.0), vec3((t_17 * (t_17 * (3.0 - (2.0 * t_17)))))), vec3(1.0, 1.0, 1.0), vec3((t_19 * (t_19 * (3.0 - (2.0 * t_19))))));
  gl_FragData[0] = tmpvar_20;
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
Float 1 [_Value]
Float 2 [_Value2]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 270 ALU, 1 TEX
dcl_2d s0
def c3, 2.00000000, -0.50000000, 1.07671583, 0.91688758
def c4, 0.00000000, 0.52300000, 0.03000000, 43758.54687500
def c5, 12.98980045, 78.23300171, 0.15915491, 0.50000000
def c6, 6.28318501, -3.14159298, -0.99000001, 100.00009918
def c7, 2.00000000, 3.00000000, 0.00000000, 0.50999999
def c8, 0.10000000, -0.95999998, 24.99998665, 0.30000001
def c9, 0.02000000, 0.49700001, -0.94999999, 19.99999619
def c10, 0.03000000, 0.50400001, -0.94000000, 16.66666603
def c11, 0.07000000, 0.49300000, 0.75000000, -0.89999998
def c12, 9.99999809, 0.02000000, 0.50999999, 0.89999998
def c13, 0.99000001, -0.89999998, 0.05000000, 0.50000000
def c14, 0.98000002, -0.89999998, 0.02000000, 0.50099999
def c15, 1.07000005, 1.00999999, 1.00000000, 0
dcl_texcoord0 v0.xy
mov r0.z, c0.x
mad r0.xy, v0, c3.x, c3.y
mul r3.xy, r0, c3.zwzw
mul r1.xy, c14.zwzw, r0.z
mad r0.xy, r3, c15.x, r1
frc r0.xy, r0
mul r0.xy, r0, c2.x
frc r0.zw, r0.xyxy
add r0.xy, r0, -r0.zwzw
mul r0.xy, r0, c5
add r0.x, r0, r0.y
mad r0.x, r0, c5.z, c5.w
frc r0.x, r0
mad r1.z, r0.x, c6.x, c6.y
sincos r0.xy, r1.z
mad r0.zw, r3.xyxy, c15.y, r1.xyxy
mul r0.x, r0.y, c4.w
frc r0.zw, r0
mul r0.zw, r0, c2.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
mul r0.zw, r0, c5.xyxy
frc r0.x, r0
mul r0.x, r0, c1
add r0.x, r0, c11.w
mul_sat r0.x, r0, c12
mad r0.y, -r0.x, c7.x, c7
mul r0.x, r0, r0
mul r1.w, r0.x, r0.y
add r0.z, r0, r0.w
mad r0.y, r0.z, c5.z, c5.w
frc r0.z, r0.y
mov r0.x, c0
mad r0.xy, c13.zwzw, r0.x, r3
mad r1.z, r0, c6.x, c6.y
frc r1.xy, r0
sincos r0.xy, r1.z
mul r0.zw, r1.xyxy, c2.x
frc r1.xy, r0.zwzw
mul r1.z, r0.y, c4.w
add r0.xy, r0.zwzw, -r1
mul r0.xy, r0, c5
add r0.x, r0, r0.y
frc r0.z, r1
mul r0.z, r0, c1.x
mad r0.y, r0.z, c12.w, -c12.w
mul_sat r0.y, r0, c12.x
mad r0.x, r0, c5.z, c5.w
frc r0.x, r0
mul r1.y, r0, r0
mad r1.z, -r0.y, c7.x, c7.y
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mul r2.x, r1.y, r1.z
mul r0.w, r0.y, c4
texld r1.xyz, v0, s0
add r0.xyz, -r1, c15.z
mad r0.xyz, r2.x, r0, r1
add r1.xyz, -r0, c15.z
mad r0.xyz, r1.w, r1, r0
frc r0.w, r0
mul r0.w, r0, c1.x
mad r0.w, r0, c14.x, c14.y
mul_sat r0.w, r0, c12.x
mad r1.w, -r0, c7.x, c7.y
mul r0.w, r0, r0
mul r1.w, r0, r1
add r1.xyz, -r0, c15.z
mad r1.xyz, r1.w, r1, r0
mov r0.w, c0.x
mul r0.xy, c12.yzzw, r0.w
mad r0.xy, r3, c12.w, r0
frc r0.zw, r0.xyxy
mov r1.w, c0.x
mul r0.xy, c11, r1.w
mul r0.zw, r0, c2.x
frc r3.zw, r0
add r0.zw, r0, -r3
mul r3.zw, r0, c5.xyxy
mad r0.xy, r3, c11.z, r0
frc r0.xy, r0
mul r0.xy, r0, c2.x
frc r0.zw, r0.xyxy
add r0.xy, r0, -r0.zwzw
add r1.w, r3.z, r3
mul r0.xy, r0, c5
mad r0.z, r1.w, c5, c5.w
frc r0.z, r0
add r0.x, r0, r0.y
add r2.xyz, -r1, c15.z
mad r2.w, r0.z, c6.x, c6.y
mad r1.w, r0.x, c5.z, c5
sincos r0.xy, r2.w
frc r0.x, r1.w
mad r1.w, r0.x, c6.x, c6.y
mul r2.w, r0.y, c4
sincos r0.xy, r1.w
frc r0.x, r2.w
mul r0.z, r0.x, c1.x
mul r0.x, r0.y, c4.w
mad r0.y, r0.z, c13.x, c13
mul_sat r0.y, r0, c12.x
mad r0.z, -r0.y, c7.x, c7.y
frc r0.x, r0
mul r0.x, r0, c1
add r0.w, r0.x, c11
mul_sat r0.w, r0, c12.x
mad r1.w, -r0, c7.x, c7.y
mul r0.w, r0, r0
mul r1.w, r0, r1
mul r0.y, r0, r0
mul r0.y, r0, r0.z
mad r0.xyz, r0.y, r2, r1
add r1.xyz, -r0, c15.z
mad r1.xyz, r1.w, r1, r0
mov r0.w, c0.x
mul r0.xy, c10, r0.w
mad r0.xy, r3, c5.w, r0
frc r0.zw, r0.xyxy
mov r1.w, c0.x
mul r0.xy, c9, r1.w
mul r0.zw, r0, c2.x
frc r3.zw, r0
add r0.zw, r0, -r3
mad r0.xy, r3, c8.w, r0
mul r3.zw, r0, c5.xyxy
frc r0.xy, r0
mul r0.xy, r0, c2.x
frc r0.zw, r0.xyxy
add r0.xy, r0, -r0.zwzw
mul r0.xy, r0, c5
add r1.w, r3.z, r3
mad r0.z, r1.w, c5, c5.w
frc r0.z, r0
add r0.x, r0, r0.y
add r2.xyz, -r1, c15.z
mad r2.w, r0.z, c6.x, c6.y
mad r1.w, r0.x, c5.z, c5
sincos r0.xy, r2.w
frc r0.x, r1.w
mad r1.w, r0.x, c6.x, c6.y
mul r2.w, r0.y, c4
sincos r0.xy, r1.w
frc r0.x, r2.w
mul r0.z, r0.x, c1.x
mul r0.x, r0.y, c4.w
add r0.y, r0.z, c10.z
mul_sat r0.y, r0, c10.w
mad r0.z, -r0.y, c7.x, c7.y
frc r0.x, r0
mul r0.x, r0, c1
add r0.w, r0.x, c9.z
mul_sat r0.w, r0, c9
mad r1.w, -r0, c7.x, c7.y
mul r0.w, r0, r0
mul r1.w, r0, r1
mul r0.y, r0, r0
mul r0.y, r0, r0.z
mad r0.xyz, r0.y, r2, r1
add r1.xyz, -r0, c15.z
mad r0.xyz, r1.w, r1, r0
mov r0.w, c0.x
mul r1.xy, c7.zwzw, r0.w
mad r1.xy, r3, c8.x, r1
frc r1.zw, r1.xyxy
mov r0.w, c0.x
mul r1.xy, c4, r0.w
mad r1.xy, r3, c4.z, r1
mul r1.zw, r1, c2.x
frc r3.xy, r1.zwzw
add r1.zw, r1, -r3.xyxy
mul r3.xy, r1.zwzw, c5
frc r1.xy, r1
mul r1.xy, r1, c2.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r0.w, r3.x, r3.y
mad r0.w, r0, c5.z, c5
frc r1.z, r0.w
mul r1.xy, r1, c5
add r0.w, r1.x, r1.y
mad r2.w, r1.z, c6.x, c6.y
sincos r1.xy, r2.w
mad r0.w, r0, c5.z, c5
frc r0.w, r0
mad r0.w, r0, c6.x, c6.y
mul r2.w, r1.y, c4
sincos r1.xy, r0.w
frc r0.w, r2
mul r1.x, r0.w, c1
mul r0.w, r1.y, c4
add r1.x, r1, c8.y
mul_sat r1.x, r1, c8.z
mad r1.y, -r1.x, c7.x, c7
frc r0.w, r0
mul r0.w, r0, c1.x
mul r1.x, r1, r1
add r0.w, r0, c6.z
mul_sat r0.w, r0, c6
mad r1.w, -r0, c7.x, c7.y
mul r0.w, r0, r0
mul r1.x, r1, r1.y
add r2.xyz, -r0, c15.z
mad r0.xyz, r1.x, r2, r0
add r1.xyz, -r0, c15.z
mul r0.w, r0, r1
mad oC0.xyz, r0.w, r1, r0
mov oC0.w, c15.z
"
}
}
 }
}
}