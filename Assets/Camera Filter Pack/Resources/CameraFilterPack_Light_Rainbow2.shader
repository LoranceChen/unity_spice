Shader "CameraFilterPack/Light_Rainbow2" {
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
uniform float _Value;
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec2 uv_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0 - vec2(0.5, 0.5));
  uv_1.x = tmpvar_2.x;
  uv_1.y = (tmpvar_2.y * _Value);
  vec2 tmpvar_3;
  tmpvar_3 = (uv_1 + (sin((((tmpvar_2.x * 10.0) * (uv_1.y * 1.11)) + _TimeX)) * 0.15));
  uv_1 = tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4.yz = vec2(1.0, 1.0);
  tmpvar_4.x = ((tmpvar_3.x * 0.1) + (_TimeX * 0.25));
  vec3 x_5;
  x_5 = ((tmpvar_4.x * 6.0) + vec3(0.0, 4.0, 2.0));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (((mix (vec3(1.0, 1.0, 1.0), clamp ((abs(((x_5 - (floor((x_5 * vec3(0.166667, 0.166667, 0.166667))) * vec3(6.0, 6.0, 6.0))) - 3.0)) - 1.0), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0)), vec3(1.0, 1.0, 1.0)) * clamp (((0.7 - abs(tmpvar_3.y)) * 3.0), 0.0, 1.0)) * (1.0 - (sin(((tmpvar_3.y * tmpvar_3.y) * 30.0)) * 0.26))) * (texture2D (_MainTex, xlv_TEXCOORD0) / 2.0).xyz);
  gl_FragData[0] = tmpvar_6;
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 52 ALU, 1 TEX
dcl_2d s0
def c2, -0.50000000, 1.11000001, 10.00000000, 0.15000001
def c3, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c4, 0.25000000, 0.10000000, 0.16666667, 6.00000000
def c5, 6.00000000, 0.00000000, 4.00000000, 2.00000000
def c6, -3.00000000, -1.00000000, 0.69999999, 3.00000000
def c7, 4.77464724, 0.50000000, 0.25999999, 1.00000000
dcl_texcoord0 v0.xy
add r1.xy, v0, c2.x
mul r1.y, r1, c1.x
mul r0.x, r1.y, c2.y
mul r0.x, r1, r0
mul r0.x, r0, c2.z
add r0.x, r0, c0
mad r0.x, r0, c3, c3.y
frc r0.x, r0
mad r1.z, r0.x, c3, c3.w
sincos r0.xy, r1.z
mov r0.x, c0
mov r0.w, r1.y
mov r0.z, r1.x
mad r0.zw, r0.y, c2.w, r0
mul r0.x, c4, r0
mad r0.x, r0.z, c4.y, r0
mad r0.xyz, r0.x, c5.x, c5.yzww
mul r1.xyz, r0, c4.z
frc r2.xyz, r1
add r1.xyz, r1, -r2
mad r0.xyz, -r1, c4.w, r0
mul r1.x, r0.w, r0.w
mad r1.x, r1, c7, c7.y
frc r1.w, r1.x
mad r2.x, r1.w, c3.z, c3.w
add r0.xyz, r0, c6.x
abs r0.xyz, r0
add_sat r1.xyz, r0, c6.y
abs r1.w, r0
sincos r0.xy, r2.x
add r0.x, -r1.w, c6.z
mad r0.w, -r0.y, c7.z, c7
mul_sat r0.x, r0, c6.w
mul r0.xyz, r1, r0.x
mul r1.xyz, r0, r0.w
texld r0.xyz, v0, s0
mul r0.xyz, r0, r1
mul oC0.xyz, r0, c3.y
mov oC0.w, c7
"
}
}
 }
}
}